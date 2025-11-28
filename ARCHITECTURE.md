# CraftLog - Architecture & Flow

## 🏗️ System Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                         CraftLog App                         │
│                                                              │
│  ┌──────────────┐          ┌───────────────┐               │
│  │              │          │               │               │
│  │ ContentView  │◄─────────┤  LogManager   │               │
│  │              │          │               │               │
│  │  - Input UI  │          │  - Business   │               │
│  │  - Recent    │          │    Logic      │               │
│  │    Logs      │          │  - Recent     │               │
│  │  - Toast     │          │    Cache      │               │
│  │              │          │  - Sync Timer │               │
│  └──────────────┘          └───────┬───────┘               │
│                                    │                        │
│                                    │                        │
│                    ┌───────────────┼───────────────┐        │
│                    │               │               │        │
│                    ▼               ▼               ▼        │
│            ┌──────────────┐ ┌──────────┐  ┌──────────────┐ │
│            │              │ │          │  │              │ │
│            │  CraftAPI    │ │LogQueue  │  │ UserDefaults │ │
│            │              │ │          │  │              │ │
│            │- Protocol    │ │- FIFO    │  │- Recent Logs │ │
│            │  Based       │ │- Persist │  │- Shared      │ │
│            │- HTTP POST   │ │          │  │  Storage     │ │
│            │              │ │          │  │              │ │
│            └──────┬───────┘ └──────────┘  └──────────────┘ │
│                   │                                         │
└───────────────────┼─────────────────────────────────────────┘
                    │
                    ▼
         ┌──────────────────────┐
         │                      │
         │  Craft Daily Notes   │
         │  API Endpoint        │
         │                      │
         │  POST /blocks        │
         │  ?position=end       │
         │  ?date=today         │
         │                      │
         └──────────────────────┘
                    │
                    ▼
         ┌──────────────────────┐
         │                      │
         │   Your Daily Note    │
         │   2025.11.29         │
         │                      │
         │   - 14:32 Log text   │
         │   - 15:45 Another    │
         │                      │
         └──────────────────────┘


┌─────────────────────────────────────────────────────────────┐
│                      Widget Extension                        │
│                                                              │
│  ┌──────────────┐          ┌──────────────┐                │
│  │              │          │              │                │
│  │SmallWidget   │          │MediumWidget  │                │
│  │              │          │              │                │
│  │- Tap Button  │          │- Recent Logs │                │
│  │- Pending #   │          │- New Button  │                │
│  │              │          │              │                │
│  └──────┬───────┘          └──────┬───────┘                │
│         │                         │                        │
│         └────────┬────────────────┘                        │
│                  │                                          │
│                  ▼                                          │
│          ┌──────────────┐                                   │
│          │              │                                   │
│          │Timeline      │                                   │
│          │Provider      │                                   │
│          │              │                                   │
│          │- Reads       │                                   │
│          │  UserDefaults│                                   │
│          │- Updates     │                                   │
│          │  15min       │                                   │
│          │              │                                   │
│          └──────┬───────┘                                   │
│                 │                                           │
└─────────────────┼───────────────────────────────────────────┘
                  │
                  ▼
         ┌──────────────────┐
         │                  │
         │  App Group       │
         │  UserDefaults    │
         │                  │
         │  group.com.      │
         │  priyan.craftlog │
         │                  │
         └──────────────────┘
```

## 🔄 Data Flow Diagrams

### Happy Path: Online Logging

```
User Types "Meeting notes"
         │
         ▼
ContentView captures input
         │
         ▼
LogManager.addLog("Meeting notes")
         │
         ▼
Generate timestamp "14:32"
         │
         ▼
Create LogEntry
├─ id: UUID()
├─ timestamp: "14:32"
├─ text: "Meeting notes"
├─ date: Date()
└─ isSynced: false
         │
         ▼
CraftAPI.appendLog(entry)
         │
         ├─ Build markdown: "- 14:32 Meeting notes"
         ├─ POST to Craft API
         └─ Await response
         │
         ▼
Success! (HTTP 200)
         │
         ├─ Mark entry.isSynced = true
         ├─ Add to recentLogs array
         ├─ Save to UserDefaults
         └─ Try sync pending queue
         │
         ▼
ContentView shows "Logged ✓"
         │
         ▼
Widget updates (next 15min cycle)
```

### Offline Path: Queue & Sync

```
User Types "Offline log"
         │
         ▼
ContentView captures input
         │
         ▼
LogManager.addLog("Offline log")
         │
         ▼
CraftAPI.appendLog(entry)
         │
         ├─ POST to Craft API
         └─ Network error! ❌
         │
         ▼
Catch error → LogQueue.enqueue(entry)
         │
         ├─ Serialize to JSON
         ├─ Append to queue array
         └─ Save to UserDefaults
         │
         ▼
Update pendingCount
         │
         ▼
ContentView shows "Queued for sync"
         │
         ▼
Widget shows pending count badge
         │
         │
         │ [Wait 60 seconds...]
         │
         ▼
Timer fires: syncPendingLogs()
         │
         ▼
While queue not empty:
├─ Dequeue oldest entry
├─ Try POST to Craft
└─ On success:
    ├─ Add to recent logs
    ├─ Continue to next
    └─ On fail:
        ├─ Re-queue entry
        └─ Break loop
         │
         ▼
Update pendingCount
         │
         ▼
Widget updates on next cycle
```

### Widget Tap Flow

```
User taps Small Widget
         │
         ▼
Widget opens URL: craftlog://newlog
         │
         ▼
CraftLogApp.onOpenURL() catches
         │
         ├─ Parse scheme: "craftlog"
         ├─ Parse host: "newlog"
         └─ Set shouldFocusInput = true
         │
         ▼
ContentView.onChange(shouldFocusInput)
         │
         ├─ Set isInputFocused = true
         ├─ Keyboard appears
         └─ Reset shouldFocusInput = false
         │
         ▼
User ready to type!
```

## 🎯 Protocol Design Pattern

### Why Protocol-Based?

```swift
// Define the contract
protocol LogDestination {
    func appendLog(_ entry: LogEntry) async throws
}

// Current implementation
class CraftDailyNotesAPI: LogDestination {
    func appendLog(_ entry: LogEntry) async throws {
        // POST to Craft endpoint
    }
}

// Future implementations (Phase 3+)
class CraftProjectAPI: LogDestination {
    let projectId: String
    func appendLog(_ entry: LogEntry) async throws {
        // POST to different Craft collection
    }
}

class AppleNotesAPI: LogDestination {
    func appendLog(_ entry: LogEntry) async throws {
        // Use Apple Notes framework
    }
}

class ObsidianAPI: LogDestination {
    let vaultPath: String
    func appendLog(_ entry: LogEntry) async throws {
        // Append to markdown file
    }
}
```

### Switching Destinations

```swift
// LogManager can work with ANY LogDestination
class LogManager {
    private let api: LogDestination
    
    init(api: LogDestination = CraftDailyNotesAPI()) {
        self.api = api
    }
    
    func addLog(_ text: String) async throws {
        let entry = LogEntry(text: text)
        try await api.appendLog(entry)  // Works with any impl!
    }
}

// User settings (Phase 3)
let selectedDestination: LogDestination = {
    switch userSettings.destination {
    case .craft:
        return CraftDailyNotesAPI()
    case .appleNotes:
        return AppleNotesAPI()
    case .obsidian:
        return ObsidianAPI(vaultPath: settings.path)
    }
}()

let manager = LogManager(api: selectedDestination)
```

## 🗄️ Data Storage Strategy

### UserDefaults Structure

```
App Group: group.com.priyan.craftlog
├─ recentLogs: [LogEntry]      // JSON array, max 20
│   └─ [{
│       id: UUID,
│       timestamp: "14:32",
│       text: "Log text",
│       date: Date,
│       isSynced: true
│     }, ...]
│
└─ pendingLogs: [LogEntry]     // JSON array, FIFO queue
    └─ [{
        id: UUID,
        timestamp: "14:32",
        text: "Offline log",
        date: Date,
        isSynced: false
      }, ...]
```

### Why UserDefaults?

**Pros:**
- ✅ Simple API
- ✅ Automatic App Group sharing
- ✅ No migration needed
- ✅ Fast for small data (<1MB)
- ✅ Atomic writes

**Cons:**
- ❌ Not ideal for >1000 logs
- ❌ Full array loaded to memory
- ❌ No queries/filtering

**Trade-off:** Perfect for MVP. Switch to CoreData in Phase 3 if needed.

## ⏱️ Timer & Sync Strategy

### Sync Timer Lifecycle

```
App Launch
    │
    ▼
LogManager.init()
    │
    ├─ Start Timer (60s interval)
    │
    ▼
Every 60 seconds:
    │
    ├─ Check if queue empty
    │   └─ If yes: continue
    │   └─ If no: ↓
    │
    ├─ syncPendingLogs()
    │   │
    │   ├─ Dequeue oldest
    │   ├─ Try POST
    │   ├─ If success: continue
    │   └─ If fail: re-queue & stop
    │
    └─ Update UI
```

### Why 60 seconds?

- Balance between battery and responsiveness
- iOS background limits respect
- User doesn't notice delay (toast confirms queue)
- Can be lowered to 30s if needed

## 🎨 UI Component Hierarchy

```
CraftLogApp
    │
    └─ NavigationView
        │
        └─ VStack
            │
            ├─ Recent Logs Section
            │   └─ VStack (if !empty)
            │       ├─ "Recent Logs" header
            │       └─ ForEach (5 logs)
            │           └─ HStack
            │               ├─ Timestamp (monospaced)
            │               ├─ Text (truncated)
            │               └─ Spacer
            │
            ├─ Spacer
            │
            └─ Input Section
                │
                ├─ HStack
                │   ├─ TextField (focused)
                │   └─ Voice Button
                │
                └─ Log Button
                    └─ Disabled if empty
```

## 🔐 Security Considerations

### Current Implementation
- ✅ HTTPS only (Craft API)
- ✅ API key in URL (embedded in link)
- ✅ No sensitive data logged
- ✅ Local storage encrypted (iOS default)

### Phase 2 Improvements
- 🔄 Move API key to Keychain
- 🔄 Add API key validation
- 🔄 Environment-based configs (dev/prod)

## 📊 Performance Characteristics

| Operation | Time | Notes |
|-----------|------|-------|
| App Launch | <1s | Fast - minimal setup |
| Log Entry | <100ms | Local first |
| API POST | 200-500ms | Network dependent |
| Widget Update | <50ms | Read from cache |
| Queue Sync | 1-5s | Depends on queue size |
| Recent Logs Load | <10ms | Small JSON decode |

## 🚦 Error Handling Strategy

```
Error Source → Detection → User Feedback → Recovery
─────────────────────────────────────────────────────
Network fail → API throw → "Queued" toast → Auto-sync
Invalid API  → HTTP 4xx → "Failed" toast → Manual retry
Queue full   → Check size → Silent drop → Log warning
Parse error  → JSON fail → "Failed" toast → Clear cache
Widget crash → Timeline → Placeholder → Rebuild

All errors logged to console for debugging.
```

---

**Architecture Status:** ✅ Phase 1 Complete

Ready for Phase 2: Voice Input & Siri Integration

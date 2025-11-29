# CraftLog - Quick Start Guide

## 🚀 Phase 1 Complete!

All code for **Phase 1** is ready. Here's what's included:

### ✅ Features Implemented

1. **Main App**
   - Text input with auto HH:MM timestamp (24hr, Singapore timezone)
   - POST to Craft Daily Notes API
   - Toast feedback: "Logged ✓", "Queued for sync"
   - Recent logs display (last 5)

2. **Offline Support**
   - Local queue using UserDefaults
   - Auto-sync every 60 seconds
   - Pending count display

3. **Widgets**
   - **Small Widget:** Quick log button
   - **Medium Widget:** Last 3 logs + new log button
   - Both show pending sync count

4. **URL Scheme**
   - `craftlog://newlog` opens app with keyboard ready

### 📦 What You Have

```
CraftLog/
├── README.md               # Full documentation
├── SETUP.md               # Detailed Xcode setup steps
├── QUICKSTART.md          # This file
├── CraftLogApp.swift      # App entry point
├── ContentView.swift      # Main UI
├── Configuration.swift    # Centralized config (NEW!)
├── Info.plist            # App configuration
├── Package.swift         # Swift Package Manager manifest
├── Models/
│   └── LogEntry.swift    # Log data model & LogError enum
├── Core/
│   ├── CraftAPI.swift    # API client (extensible, no force unwraps!)
│   ├── LogQueue.swift    # Thread-safe offline queue (actor!)
│   └── LogManager.swift  # Business logic (@MainActor)
└── Widgets/
    ├── CraftLogWidgets.swift  # Widget bundle & provider
    ├── SmallWidget.swift      # Quick log widget
    └── MediumWidget.swift     # Recent logs widget
```

### ⚡ Fastest Way to Test (5 Minutes)

1. **Open Xcode** (15+)
2. **File → New → Project → iOS App**
   - Name: `CraftLog`
   - Bundle ID: `com.priyan.craftlog`
   - Interface: SwiftUI

3. **Replace files:**
   - Delete default `ContentView.swift` and `CraftLogApp.swift`
   - Drag ALL files from this folder into Xcode
   - Keep folder structure

4. **Add Widget Extension:**
   - File → New → Target → Widget Extension
   - Name: `CraftLogWidgets`
   - Move widget files to widget target

5. **Configure App Groups:**
   - Select `CraftLog` target → Signing & Capabilities
   - Add capability: **App Groups**
   - Create: `group.com.priyan.craftlog`
   - Repeat for `CraftLogWidgets` target (same group!)

6. **Set file targets:**
   - Select `Configuration.swift` → File Inspector → Check BOTH targets
   - Select `Models/LogEntry.swift` → File Inspector → Check BOTH targets
   - Select `Core/LogQueue.swift` → File Inspector → Check BOTH targets

7. **Build & Run** (Cmd+R)

### 🧪 Test Checklist

- [ ] App opens with keyboard ready
- [ ] Type "test log" and hit Log button
- [ ] See "Logged ✓" toast
- [ ] Check Craft daily note - log should appear as `- HH:MM test log`
- [ ] Enable Airplane Mode
- [ ] Log "offline test"
- [ ] See "Queued for sync" toast
- [ ] Disable Airplane Mode
- [ ] Wait 60 seconds - log should sync
- [ ] Add widgets to home screen
- [ ] Tap widget → app opens with keyboard

### 🎯 Your Craft API

The app is configured in `Configuration.swift`:
```swift
static let defaultCraftAPIURL = "https://connect.craft.do/links/4LRilONEs5e/api/v1"
```

**Other customizable settings:**
- `maxLogLength` - Max characters (default: 10,000)
- `widgetRefreshInterval` - Update frequency (default: 15 min)
- `syncTimerInterval` - Background sync (default: 60 sec)
- `defaultTimezone` - Timestamp zone (default: "Asia/Singapore")

Logs append to **today's daily note** as markdown bullets with timestamps.

### 🐛 Common Issues

**"Cannot find LogEntry"**
→ Make sure `LogEntry.swift` has both targets checked

**Widget not updating**
→ Both targets must share same App Group: `group.com.priyan.craftlog`

**Keyboard doesn't appear**
→ Check ContentView has `@FocusState` and `.onAppear { isInputFocused = true }`

**Network error**
→ Verify Craft API link is still valid (check Craft settings)

### 📱 Next: Phase 2

Once Phase 1 works:
- Voice input button (uses iOS dictation)
- Siri Shortcuts integration
- Apple Watch support (via shortcuts)
- Settings screen (12hr/24hr toggle)

### 🔧 Architecture Notes

**Protocol-based design** makes it easy to add new destinations:

```swift
// Already implemented:
class CraftDailyNotesAPI: LogDestination { ... }

// Easy to add:
class AppleNotesAPI: LogDestination { ... }
class ObsidianAPI: LogDestination { ... }
```

Just implement `appendLog()` method for new destinations.

### 📞 Need Help?

1. Read **SETUP.md** for detailed Xcode configuration
2. Read **README.md** for architecture details
3. Check Build Log for specific errors
4. Clean build folder: Shift+Cmd+K

---

**Built with ❤️ for NPSOY**

Phase 1 complete. Ready to log! 🎉

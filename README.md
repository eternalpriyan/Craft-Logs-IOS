# CraftLog - Quick Logging to Craft Daily Notes

A native iOS app for quick timestamped logging to Craft daily notes with offline support and widgets.

## Features

### Phase 1 (Complete)
- ✅ Text input with automatic HH:MM timestamp
- ✅ POST to Craft Daily Notes API
- ✅ Toast feedback ("Logged ✓", "Queued for sync", etc.)
- ✅ Offline queue with automatic background sync
- ✅ Small widget (tap to log)
- ✅ Medium widget (shows last 3 logs + new log button)
- ✅ App icon Quick Actions

### Phase 2 (Planned)
- ⏳ Voice input button (in-app)
- ⏳ Siri shortcut integration
- ⏳ Apple Watch support (via Siri shortcut)
- ⏳ Settings: 12hr/24hr format, custom API endpoints

### Phase 3 (Future)
- 🔮 Support for multiple log destinations (Apple Notes, Obsidian)
- 🔮 Log templates
- 🔮 Search recent logs

## Architecture

Protocol-based design for extensibility:

```swift
protocol LogDestination {
    func appendLog(_ entry: LogEntry) async throws
}

// Current implementation
class CraftDailyNotesAPI: LogDestination { ... }

// Future implementations
class CraftOtherAPI: LogDestination { ... }
class AppleNotesAPI: LogDestination { ... }
class ObsidianAPI: LogDestination { ... }
```

## Project Structure

```
CraftLog/
├── CraftLogApp.swift           # Main app entry point
├── ContentView.swift            # Main UI with input field
├── Info.plist                   # App configuration
├── Models/
│   └── LogEntry.swift          # Log entry model
├── Core/
│   ├── CraftAPI.swift          # Craft API client (protocol-based)
│   ├── LogQueue.swift          # Offline queue manager
│   └── LogManager.swift        # Coordinating logic
└── Widgets/
    ├── CraftLogWidgets.swift   # Widget bundle
    ├── SmallWidget.swift       # Quick log button widget
    └── MediumWidget.swift      # Recent logs widget
```

## Setup

1. **Open in Xcode**
   - Requires Xcode 15+ and iOS 17+
   - Open `CraftLog.xcodeproj`

2. **Configure Bundle ID**
   - Main app: `com.priyan.craftlog`
   - Widget extension: `com.priyan.craftlog.widgets`

3. **Add App Group**
   - Go to Signing & Capabilities
   - Add App Groups capability
   - Create group: `group.com.priyan.craftlog`
   - Add to both main app and widget extension

4. **Configure Craft API**
   - The API endpoint is already set to: `https://connect.craft.do/links/4LRilONEs5e/api/v1`
   - To change: Edit `CraftAPI.swift` and update `baseURL`

5. **Build and Run**
   - Select target device/simulator
   - Cmd+R to build and run
   - Add widgets from home screen

## Usage

### Main App
1. Tap app icon
2. Type your log message
3. Hit "Log" button or press Return
4. See toast confirmation

### Small Widget
- Tap widget → Opens app ready for input

### Medium Widget
- View last 3 logs
- Tap "New Log" → Opens app ready for input

### Offline Mode
- Logs are queued locally if offline
- Automatically synced when connection returns
- See pending count in widget and app

## Log Format

Logs are appended to today's Craft daily note as:

```markdown
- HH:MM Your log message here
```

Timestamp uses 24-hour format and Singapore timezone (GMT+8).

## Build Configuration

**Minimum Deployment Target:** iOS 17.0

**Required Capabilities:**
- App Groups (for widget data sharing)
- Background Modes (for sync)

**Frameworks:**
- SwiftUI
- WidgetKit
- Combine

## Testing

1. **Test logging:**
   - Type a message and log it
   - Check your Craft daily note for today

2. **Test offline queue:**
   - Enable Airplane Mode
   - Log a few messages
   - See "Queued for sync" toast
   - Disable Airplane Mode
   - Logs should sync automatically

3. **Test widgets:**
   - Add small widget to home screen
   - Add medium widget to home screen
   - Verify they show recent logs and pending count

## Troubleshooting

**Widget not showing logs:**
- Ensure App Group is configured correctly
- Both app and widget must use same group ID: `group.com.priyan.craftlog`

**API errors:**
- Check network connection
- Verify Craft API link is valid
- Check Craft API documentation if endpoint format changed

**Sync not working:**
- Check Background App Refresh is enabled in Settings
- Logs sync every 60 seconds when app is active

## License

MIT License - See LICENSE file for details

## Credits

Built with ❤️ for Nithya Priyan School of Yoga

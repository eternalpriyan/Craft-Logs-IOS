# Xcode Project Setup Instructions

Since I can't create the actual `.xcodeproj` file directly, follow these steps to set up the project in Xcode:

## Step 1: Create New Project

1. Open Xcode
2. File → New → Project
3. Choose **iOS** → **App**
4. Fill in:
   - Product Name: `CraftLog`
   - Team: Your team
   - Organization Identifier: `com.priyan`
   - Bundle Identifier: `com.priyan.craftlog`
   - Interface: **SwiftUI**
   - Language: **Swift**
   - Storage: None
   - Include Tests: No

## Step 2: Add Files to Project

1. Delete the default `ContentView.swift` and `CraftLogApp.swift` from Xcode
2. Drag all the files from this directory into Xcode, maintaining folder structure:
   - `CraftLogApp.swift`
   - `ContentView.swift`
   - `Info.plist`
   - `Models/` folder with `LogEntry.swift`
   - `Core/` folder with all Core files
   - `Widgets/` folder (we'll configure this as an extension)

3. Select "Create groups" and ensure "CraftLog" target is checked

## Step 3: Add Widget Extension

1. File → New → Target
2. Choose **Widget Extension**
3. Fill in:
   - Product Name: `CraftLogWidgets`
   - Include Configuration Intent: **No**
4. Activate the scheme when prompted
5. Delete the default widget files Xcode creates
6. Add the widget files from `Widgets/` folder to the widget target:
   - `CraftLogWidgets.swift`
   - `SmallWidget.swift`
   - `MediumWidget.swift`

## Step 4: Configure App Groups

### For Main App:
1. Select `CraftLog` target
2. Go to **Signing & Capabilities**
3. Click **+ Capability**
4. Add **App Groups**
5. Click **+** and add: `group.com.priyan.craftlog`

### For Widget Extension:
1. Select `CraftLogWidgets` target
2. Repeat steps 2-5 above
3. **Must use same group ID**: `group.com.priyan.craftlog`

## Step 5: Link Shared Code

The widget needs access to shared models and managers:

1. Select `LogEntry.swift` in Project Navigator
2. In File Inspector (right panel), check **both** targets:
   - ✅ CraftLog
   - ✅ CraftLogWidgets

3. Repeat for:
   - `LogQueue.swift`
   - `CraftAPI.swift` (if widgets need it in future)

## Step 6: Configure Info.plist

1. Select `CraftLog` target
2. Go to **Info** tab
3. Verify URL Types includes:
   - URL Schemes: `craftlog`
   - Identifier: `com.priyan.craftlog`

(This should already be in the Info.plist file)

## Step 7: Set Deployment Target

1. Select `CraftLog` target
2. General → Deployment Info
3. Set **Minimum Deployments**: iOS 17.0
4. Repeat for `CraftLogWidgets` target

## Step 8: Build Settings

### Main App Target (CraftLog):
- Display Name: `CraftLog`
- Bundle Identifier: `com.priyan.craftlog`
- Version: 1.0
- Build: 1

### Widget Target (CraftLogWidgets):
- Bundle Identifier: `com.priyan.craftlog.widgets`
- Version: 1.0
- Build: 1

## Step 9: Test Build

1. Select iPhone simulator (iOS 17+)
2. Select `CraftLog` scheme
3. Cmd+B to build
4. Fix any build errors (usually path or target membership issues)
5. Cmd+R to run

## Step 10: Test Widgets

1. With app running, press Home button
2. Long press on home screen → Add Widget
3. Find "CraftLog" in widget gallery
4. Add Small and/or Medium widget
5. Verify widgets appear and tap functionality works

## Common Issues

### Build Error: "Cannot find type 'LogEntry' in scope"
**Fix:** Ensure `LogEntry.swift` has both targets checked (CraftLog + CraftLogWidgets)

### Widget Not Updating
**Fix:** 
1. Verify App Group is identical in both targets
2. Check UserDefaults suite name matches: `group.com.priyan.craftlog`
3. Rebuild widget target

### URL Scheme Not Working
**Fix:**
1. Verify Info.plist has CFBundleURLTypes
2. Check URL scheme is exactly: `craftlog` (lowercase, no spaces)
3. Add this to CraftLogApp.swift:

```swift
.onOpenURL { url in
    if url.scheme == "craftlog" && url.host == "newlog" {
        // Focus input field
    }
}
```

### App Group Not Available
**Fix:**
1. Ensure you're logged into Apple Developer account in Xcode
2. Both targets must use same Team
3. App Group ID must be unique and follow format: `group.com.priyan.craftlog`

## File Structure Verification

After setup, your Xcode project should look like:

```
CraftLog/
├── CraftLog/                     (Main App Target)
│   ├── CraftLogApp.swift
│   ├── ContentView.swift
│   ├── Info.plist
│   ├── Models/
│   │   └── LogEntry.swift       (✓ Both targets)
│   └── Core/
│       ├── CraftAPI.swift
│       ├── LogQueue.swift       (✓ Both targets)
│       └── LogManager.swift
└── CraftLogWidgets/              (Widget Extension Target)
    ├── CraftLogWidgets.swift
    ├── SmallWidget.swift
    ├── MediumWidget.swift
    └── Info.plist
```

## Next Steps

Once built successfully:
1. Test logging functionality
2. Test offline queue (Airplane mode)
3. Test widgets on device or simulator
4. Proceed to Phase 2 (Voice input, Siri shortcuts)

## Need Help?

If you encounter issues:
1. Check Build Log for specific errors
2. Verify all file targets are correct
3. Clean Build Folder (Shift+Cmd+K)
4. Delete Derived Data
5. Restart Xcode

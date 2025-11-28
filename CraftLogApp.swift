import SwiftUI

@main
struct CraftLogApp: App {
    @StateObject private var logManager = LogManager()
    @State private var shouldFocusInput = false
    
    var body: some Scene {
        WindowGroup {
            ContentView(shouldFocusInput: $shouldFocusInput)
                .environmentObject(logManager)
                .onOpenURL { url in
                    // Handle craftlog://newlog from widgets
                    if url.scheme == "craftlog" && url.host == "newlog" {
                        shouldFocusInput = true
                    }
                }
        }
    }
}

import Foundation

/// Centralized configuration for the CraftLog app
enum Configuration {
    /// App Group identifier for sharing data between app and widgets
    static let appGroupIdentifier = "group.com.priyan.craftlog"

    /// Default Craft.do API URL
    static let defaultCraftAPIURL = "https://connect.craft.do/links/4LRilONEs5e/api/v1"

    /// Default timezone for timestamps
    static let defaultTimezone = "Asia/Singapore"

    /// Maximum log text length (characters)
    static let maxLogLength = 10000

    /// Widget refresh interval (minutes)
    static let widgetRefreshInterval = 15

    /// Sync timer interval (seconds)
    static let syncTimerInterval: TimeInterval = 60

    /// Maximum recent logs to keep
    static let maxRecentLogs = 20

    /// UserDefaults keys
    enum Keys {
        static let recentLogs = "recentLogs"
        static let pendingLogs = "pendingLogs"
    }
}

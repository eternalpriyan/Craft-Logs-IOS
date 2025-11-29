import WidgetKit
import SwiftUI

@main
struct CraftLogWidgets: WidgetBundle {
    var body: some Widget {
        SmallWidget()
        MediumWidget()
    }
}

struct LogWidgetEntry: TimelineEntry {
    let date: Date
    let recentLogs: [LogEntry]
    let pendingCount: Int
}

struct LogWidgetProvider: TimelineProvider {
    private let userDefaults: UserDefaults?

    init() {
        self.userDefaults = UserDefaults(suiteName: Configuration.appGroupIdentifier)
    }

    func placeholder(in context: Context) -> LogWidgetEntry {
        LogWidgetEntry(
            date: Date(),
            recentLogs: [],
            pendingCount: 0
        )
    }

    func getSnapshot(in context: Context, completion: @escaping (LogWidgetEntry) -> Void) {
        let entry = LogWidgetEntry(
            date: Date(),
            recentLogs: getRecentLogs(),
            pendingCount: getPendingCount()
        )
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<LogWidgetEntry>) -> Void) {
        let entry = LogWidgetEntry(
            date: Date(),
            recentLogs: getRecentLogs(),
            pendingCount: getPendingCount()
        )

        // Update every configured interval
        let nextUpdate = Calendar.current.date(
            byAdding: .minute,
            value: Configuration.widgetRefreshInterval,
            to: Date()
        ) ?? Date().addingTimeInterval(900) // Fallback to 15 minutes

        let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
        completion(timeline)
    }

    private func getRecentLogs() -> [LogEntry] {
        guard let userDefaults = userDefaults,
              let data = userDefaults.data(forKey: Configuration.Keys.recentLogs) else {
            return []
        }

        do {
            return try JSONDecoder().decode([LogEntry].self, from: data)
        } catch {
            print("⚠️ Widget failed to decode recent logs: \(error.localizedDescription)")
            return []
        }
    }

    private func getPendingCount() -> Int {
        guard let userDefaults = userDefaults,
              let data = userDefaults.data(forKey: Configuration.Keys.pendingLogs) else {
            return 0
        }

        do {
            let logs = try JSONDecoder().decode([LogEntry].self, from: data)
            return logs.count
        } catch {
            print("⚠️ Widget failed to decode pending logs: \(error.localizedDescription)")
            return 0
        }
    }
}

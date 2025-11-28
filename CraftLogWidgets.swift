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
    private let userDefaults = UserDefaults(suiteName: "group.com.priyan.craftlog")!
    
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
        
        // Update every 15 minutes
        let nextUpdate = Calendar.current.date(byAdding: .minute, value: 15, to: Date())!
        let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
        completion(timeline)
    }
    
    private func getRecentLogs() -> [LogEntry] {
        guard let data = userDefaults.data(forKey: "recentLogs") else { return [] }
        return (try? JSONDecoder().decode([LogEntry].self, from: data)) ?? []
    }
    
    private func getPendingCount() -> Int {
        guard let data = userDefaults.data(forKey: "pendingLogs") else { return 0 }
        let logs = (try? JSONDecoder().decode([LogEntry].self, from: data)) ?? []
        return logs.count
    }
}

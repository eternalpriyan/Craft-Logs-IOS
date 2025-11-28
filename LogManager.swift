import Foundation
import SwiftUI
import Combine

@MainActor
class LogManager: ObservableObject {
    @Published var recentLogs: [LogEntry] = []
    @Published var pendingCount: Int = 0
    
    private let api: LogDestination
    private let queue: LogQueue
    private let userDefaults = UserDefaults(suiteName: "group.com.priyan.craftlog")!
    private let recentLogsKey = "recentLogs"
    private var syncTimer: Timer?
    
    init(api: LogDestination = CraftDailyNotesAPI()) {
        self.api = api
        self.queue = LogQueue()
        
        loadRecentLogs()
        updatePendingCount()
        startSyncTimer()
    }
    
    func addLog(_ text: String) async throws {
        let entry = LogEntry(text: text)
        
        // Try to send immediately
        do {
            try await api.appendLog(entry)
            
            // Success - add to recent logs
            var synced = entry
            synced.isSynced = true
            addToRecentLogs(synced)
            
            // Try to sync any pending logs
            await syncPendingLogs()
        } catch {
            // Failed - queue for later
            queue.enqueue(entry)
            updatePendingCount()
            throw LogError.offline
        }
    }
    
    private func addToRecentLogs(_ entry: LogEntry) {
        recentLogs.insert(entry, at: 0)
        if recentLogs.count > 20 {
            recentLogs = Array(recentLogs.prefix(20))
        }
        saveRecentLogs()
    }
    
    private func loadRecentLogs() {
        guard let data = userDefaults.data(forKey: recentLogsKey) else { return }
        recentLogs = (try? JSONDecoder().decode([LogEntry].self, from: data)) ?? []
    }
    
    private func saveRecentLogs() {
        let data = try? JSONEncoder().encode(recentLogs)
        userDefaults.set(data, forKey: recentLogsKey)
    }
    
    private func updatePendingCount() {
        pendingCount = queue.count
    }
    
    private func startSyncTimer() {
        syncTimer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { [weak self] _ in
            Task { @MainActor [weak self] in
                await self?.syncPendingLogs()
            }
        }
    }
    
    func syncPendingLogs() async {
        while !queue.isEmpty {
            guard let entry = queue.dequeue() else { break }
            
            do {
                try await api.appendLog(entry)
                var synced = entry
                synced.isSynced = true
                addToRecentLogs(synced)
            } catch {
                // Failed - put it back
                queue.enqueue(entry)
                break
            }
        }
        updatePendingCount()
    }
    
    deinit {
        syncTimer?.invalidate()
    }
}

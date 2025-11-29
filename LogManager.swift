import Foundation
import SwiftUI
import Combine

@MainActor
class LogManager: ObservableObject {
    @Published var recentLogs: [LogEntry] = []
    @Published var pendingCount: Int = 0

    private let api: LogDestination
    private let queue: LogQueue
    private let userDefaults: UserDefaults
    private var syncTimer: Timer?

    init(api: LogDestination = CraftDailyNotesAPI()) {
        self.api = api
        self.queue = LogQueue()

        // Safe initialization of UserDefaults
        guard let defaults = UserDefaults(suiteName: Configuration.appGroupIdentifier) else {
            fatalError("Failed to initialize UserDefaults with app group identifier: \(Configuration.appGroupIdentifier). Ensure the app group is properly configured in your Xcode project.")
        }
        self.userDefaults = defaults

        loadRecentLogs()

        Task {
            await updatePendingCount()
        }

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
            await queue.enqueue(entry)
            await updatePendingCount()
            throw LogError.offline
        }
    }
    
    private func addToRecentLogs(_ entry: LogEntry) {
        recentLogs.insert(entry, at: 0)
        if recentLogs.count > Configuration.maxRecentLogs {
            recentLogs = Array(recentLogs.prefix(Configuration.maxRecentLogs))
        }
        saveRecentLogs()
    }
    
    private func loadRecentLogs() {
        guard let data = userDefaults.data(forKey: Configuration.Keys.recentLogs) else { return }
        do {
            recentLogs = try JSONDecoder().decode([LogEntry].self, from: data)
        } catch {
            print("⚠️ Failed to decode recent logs: \(error.localizedDescription)")
            recentLogs = []
        }
    }
    
    private func saveRecentLogs() {
        do {
            let data = try JSONEncoder().encode(recentLogs)
            userDefaults.set(data, forKey: Configuration.Keys.recentLogs)
        } catch {
            print("⚠️ Failed to encode recent logs: \(error.localizedDescription)")
        }
    }
    
    private func updatePendingCount() async {
        pendingCount = await queue.count
    }
    
    private func startSyncTimer() {
        syncTimer = Timer.scheduledTimer(withTimeInterval: Configuration.syncTimerInterval, repeats: true) { [weak self] _ in
            Task { @MainActor [weak self] in
                await self?.syncPendingLogs()
            }
        }
    }
    
    func syncPendingLogs() async {
        while await !queue.isEmpty {
            guard let entry = await queue.dequeue() else { break }

            do {
                try await api.appendLog(entry)
                var synced = entry
                synced.isSynced = true
                addToRecentLogs(synced)
            } catch {
                // Failed - put it back
                await queue.enqueue(entry)
                break
            }
        }
        await updatePendingCount()
    }
    
    deinit {
        syncTimer?.invalidate()
    }
}

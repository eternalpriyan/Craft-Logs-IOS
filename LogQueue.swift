import Foundation

/// Thread-safe log queue using actor for synchronization
actor LogQueue {
    private let userDefaults: UserDefaults

    init() {
        guard let defaults = UserDefaults(suiteName: Configuration.appGroupIdentifier) else {
            fatalError("Failed to initialize UserDefaults with app group identifier: \(Configuration.appGroupIdentifier). Ensure the app group is properly configured in your Xcode project.")
        }
        self.userDefaults = defaults
    }

    func enqueue(_ entry: LogEntry) {
        var queue = getQueue()
        queue.append(entry)
        save(queue)
    }

    func dequeue() -> LogEntry? {
        var queue = getQueue()
        guard !queue.isEmpty else { return nil }
        let entry = queue.removeFirst()
        save(queue)
        return entry
    }

    private func getQueue() -> [LogEntry] {
        guard let data = userDefaults.data(forKey: Configuration.Keys.pendingLogs) else { return [] }
        do {
            return try JSONDecoder().decode([LogEntry].self, from: data)
        } catch {
            print("⚠️ Failed to decode pending logs: \(error.localizedDescription)")
            return []
        }
    }

    private func save(_ queue: [LogEntry]) {
        do {
            let data = try JSONEncoder().encode(queue)
            userDefaults.set(data, forKey: Configuration.Keys.pendingLogs)
        } catch {
            print("⚠️ Failed to encode pending logs: \(error.localizedDescription)")
        }
    }

    func clear() {
        userDefaults.removeObject(forKey: Configuration.Keys.pendingLogs)
    }

    var count: Int {
        getQueue().count
    }

    var isEmpty: Bool {
        count == 0
    }
}

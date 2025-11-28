import Foundation

class LogQueue {
    private let userDefaults = UserDefaults(suiteName: "group.com.priyan.craftlog")!
    private let queueKey = "pendingLogs"
    
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
    
    func getQueue() -> [LogEntry] {
        guard let data = userDefaults.data(forKey: queueKey) else { return [] }
        return (try? JSONDecoder().decode([LogEntry].self, from: data)) ?? []
    }
    
    func save(_ queue: [LogEntry]) {
        let data = try? JSONEncoder().encode(queue)
        userDefaults.set(data, forKey: queueKey)
    }
    
    func clear() {
        userDefaults.removeObject(forKey: queueKey)
    }
    
    var count: Int {
        getQueue().count
    }
    
    var isEmpty: Bool {
        count == 0
    }
}

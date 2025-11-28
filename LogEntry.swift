import Foundation

struct LogEntry: Identifiable, Codable {
    let id: UUID
    let timestamp: String
    let text: String
    let date: Date
    var isSynced: Bool
    
    init(text: String, timestamp: String? = nil) {
        self.id = UUID()
        self.date = Date()
        self.timestamp = timestamp ?? Self.currentTimestamp()
        self.text = text
        self.isSynced = false
    }
    
    static func currentTimestamp() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.timeZone = TimeZone(identifier: "Asia/Singapore")
        return formatter.string(from: Date())
    }
    
    var markdown: String {
        "- \(timestamp) \(text)"
    }
}

enum LogError: Error {
    case offline
    case failed(String)
}

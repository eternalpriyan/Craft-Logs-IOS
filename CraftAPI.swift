import Foundation

protocol LogDestination {
    func appendLog(_ entry: LogEntry) async throws
}

class CraftDailyNotesAPI: LogDestination {
    private let baseURL: URL
    
    init(linkURL: String = "https://connect.craft.do/links/4LRilONEs5e/api/v1") {
        self.baseURL = URL(string: linkURL)!
    }
    
    func appendLog(_ entry: LogEntry) async throws {
        let endpoint = baseURL.appendingPathComponent("blocks")
        
        var request = URLRequest(url: endpoint)
        request.httpMethod = "POST"
        request.setValue("text/markdown", forHTTPHeaderField: "Content-Type")
        
        // Add position query parameter for "end" of "today"
        var components = URLComponents(url: endpoint, resolvingAgainstBaseURL: false)!
        components.queryItems = [
            URLQueryItem(name: "position", value: "{\"position\":\"end\",\"date\":\"today\"}")
        ]
        request.url = components.url
        
        // Body is just the markdown text
        request.httpBody = entry.markdown.data(using: .utf8)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw LogError.failed("Invalid response")
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            let errorBody = String(data: data, encoding: .utf8) ?? "Unknown error"
            throw LogError.failed("HTTP \(httpResponse.statusCode): \(errorBody)")
        }
    }
}

// Future implementations:
// class CraftOtherAPI: LogDestination { ... }
// class AppleNotesAPI: LogDestination { ... }
// class ObsidianAPI: LogDestination { ... }

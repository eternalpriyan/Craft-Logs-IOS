import Foundation

protocol LogDestination {
    func appendLog(_ entry: LogEntry) async throws
}

class CraftDailyNotesAPI: LogDestination {
    private let baseURL: URL

    init(linkURL: String = Configuration.defaultCraftAPIURL) {
        guard let url = URL(string: linkURL) else {
            fatalError("Invalid Craft API URL: \(linkURL)")
        }
        self.baseURL = url
    }

    func appendLog(_ entry: LogEntry) async throws {
        let endpoint = baseURL.appendingPathComponent("blocks")

        var request = URLRequest(url: endpoint)
        request.httpMethod = "POST"
        request.setValue("text/markdown", forHTTPHeaderField: "Content-Type")

        // Add position query parameter for "end" of "today"
        guard var components = URLComponents(url: endpoint, resolvingAgainstBaseURL: false) else {
            throw LogError.failed("Invalid URL components")
        }
        components.queryItems = [
            URLQueryItem(name: "position", value: "{\"position\":\"end\",\"date\":\"today\"}")
        ]

        guard let finalURL = components.url else {
            throw LogError.failed("Failed to construct URL with query parameters")
        }
        request.url = finalURL

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

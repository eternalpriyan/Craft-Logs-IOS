import WidgetKit
import SwiftUI

struct MediumWidget: Widget {
    let kind: String = "MediumWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: LogWidgetProvider()) { entry in
            MediumWidgetView(entry: entry)
        }
        .configurationDisplayName("Recent Logs")
        .description("View recent logs and add new ones")
        .supportedFamilies([.systemMedium])
    }
}

struct MediumWidgetView: View {
    let entry: LogWidgetEntry
    
    var body: some View {
        HStack(spacing: 0) {
            // Recent logs section (70%)
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text("Recent Logs")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    if entry.pendingCount > 0 {
                        Text("\(entry.pendingCount) pending")
                            .font(.caption2)
                            .foregroundColor(.orange)
                    }
                }
                
                if entry.recentLogs.isEmpty {
                    Spacer()
                    Text("No logs yet")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Spacer()
                } else {
                    ForEach(entry.recentLogs.prefix(3)) { log in
                        HStack(alignment: .top, spacing: 6) {
                            Text(log.timestamp)
                                .font(.system(.caption2, design: .monospaced))
                                .foregroundColor(.secondary)
                                .frame(width: 35, alignment: .leading)
                            
                            Text(log.text)
                                .font(.caption)
                                .lineLimit(1)
                                .truncationMode(.tail)
                            
                            Spacer(minLength: 0)
                        }
                        .padding(.vertical, 2)
                    }
                    
                    Spacer()
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            
            // New log button section (30%)
            Link(destination: URL(string: "craftlog://newlog")!) {
                VStack(spacing: 6) {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 32))
                        .foregroundColor(.blue)
                    
                    Text("New Log")
                        .font(.caption2)
                        .fontWeight(.medium)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.blue.opacity(0.1))
            }
        }
        .background(Color(.systemBackground))
    }
}

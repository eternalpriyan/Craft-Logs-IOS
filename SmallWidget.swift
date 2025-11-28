import WidgetKit
import SwiftUI

struct SmallWidget: Widget {
    let kind: String = "SmallWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: LogWidgetProvider()) { entry in
            SmallWidgetView(entry: entry)
        }
        .configurationDisplayName("Quick Log")
        .description("Tap to add a quick log")
        .supportedFamilies([.systemSmall])
    }
}

struct SmallWidgetView: View {
    let entry: LogWidgetEntry
    
    var body: some View {
        ZStack {
            Color.blue.opacity(0.1)
            
            VStack(spacing: 8) {
                Image(systemName: "square.and.pencil")
                    .font(.system(size: 40))
                    .foregroundColor(.blue)
                
                Text("Quick Log")
                    .font(.caption)
                    .fontWeight(.medium)
                
                if entry.pendingCount > 0 {
                    Text("\(entry.pendingCount) pending")
                        .font(.caption2)
                        .foregroundColor(.orange)
                }
            }
        }
        .widgetURL(URL(string: "craftlog://newlog"))
    }
}

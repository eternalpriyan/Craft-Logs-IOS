// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "CraftLog",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "CraftLog",
            targets: ["CraftLog"]),
    ],
    targets: [
        .target(
            name: "CraftLog",
            dependencies: [],
            path: ".",
            sources: [
                "CraftLogApp.swift",
                "ContentView.swift",
                "LogEntry.swift",
                "CraftAPI.swift",
                "LogQueue.swift",
                "LogManager.swift",
                "Configuration.swift",
                "CraftLogWidgets.swift",
                "SmallWidget.swift",
                "MediumWidget.swift"
            ]
        )
    ]
)

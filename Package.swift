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
                "Configuration.swift",
                "Models/LogEntry.swift",
                "Core/CraftAPI.swift",
                "Core/LogQueue.swift",
                "Core/LogManager.swift",
                "Widgets/CraftLogWidgets.swift",
                "Widgets/SmallWidget.swift",
                "Widgets/MediumWidget.swift"
            ]
        )
    ]
)

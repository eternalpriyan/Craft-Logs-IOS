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
                "Models/LogEntry.swift",
                "Core/CraftAPI.swift",
                "Core/LogQueue.swift",
                "Core/LogManager.swift"
            ]
        ),
        .target(
            name: "CraftLogWidgets",
            dependencies: [],
            path: "Widgets",
            sources: [
                "CraftLogWidgets.swift",
                "SmallWidget.swift",
                "MediumWidget.swift"
            ]
        )
    ]
)

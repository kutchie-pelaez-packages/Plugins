// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "Plugins",
    platforms: [.iOS(.v16)],
    products: [
        .plugin(name: "AssetsPlugin", targets: ["AssetsPlugin"])
    ],
    targets: [
        .executableTarget(name: "AssetsPluginTool"),
        .plugin(name: "AssetsPlugin", capability: .buildTool(), dependencies: [
            .target(name: "AssetsPluginTool")
        ])
    ]
)

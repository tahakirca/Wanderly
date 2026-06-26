// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "DesignSystem",
    platforms: [.iOS(.v17)],
    products: [
        .library(name: "DesignSystem", targets: ["DesignSystem"]),
    ],
    dependencies: [
        .package(path: "../Domain"),
        .package(url: "https://github.com/onevcat/Kingfisher.git", from: "8.0.0"),
        .package(url: "https://github.com/SimplyDanny/SwiftLintPlugins", from: "0.63.2"),
    ],
    targets: [
        .target(
            name: "DesignSystem",
            dependencies: [
                "Domain",
                .product(name: "Kingfisher", package: "Kingfisher"),
            ],
            plugins: [.plugin(name: "SwiftLintBuildToolPlugin", package: "SwiftLintPlugins")]
        ),
    ]
)

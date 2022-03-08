// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ProcessEnv",
    platforms: [.macOS(.v10_11)],
    products: [
        .library(name: "ProcessEnv", targets: ["ProcessEnv"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "ProcessEnv", dependencies: []),
        .testTarget(name: "ProcessEnvTests", dependencies: ["ProcessEnv"]),
    ]
)

// swift-tools-version: 5.8

import PackageDescription

let package = Package(
	name: "ProcessEnv",
	platforms: [.macOS(.v10_13)],
	products: [
		.library(name: "ProcessEnv", targets: ["ProcessEnv"]),
	],
	dependencies: [],
	targets: [
		.target(name: "ProcessEnv", dependencies: []),
		.testTarget(name: "ProcessEnvTests", dependencies: ["ProcessEnv"]),
	]
)

let swiftSettings: [SwiftSetting] = [
	.enableExperimentalFeature("StrictConcurrency")
]

for target in package.targets {
	var settings = target.swiftSettings ?? []
	settings.append(contentsOf: swiftSettings)
	target.swiftSettings = settings
}

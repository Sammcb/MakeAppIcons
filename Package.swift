// swift-tools-version:5.3
import PackageDescription

let package = Package(
	name: "MakeAppIcons",
	dependencies: [
		.package(url: "https://github.com/apple/swift-argument-parser", from: "0.3.0"),
	],
	targets: [
		.target(
			name: "MakeAppIcons",
			dependencies: [
				.product(name: "ArgumentParser", package: "swift-argument-parser"),
			]
		),
		.testTarget(
			name: "MakeAppIconsTests",
			dependencies: ["MakeAppIcons"],
			resources: [.process("Resources")]
		),
	]
)

// swift-tools-version:5.5
import PackageDescription

let package = Package(
	name: "MakeAppIcons",
	dependencies: [
		.package(url: "https://github.com/apple/swift-argument-parser", from: "1.0.1"),
	],
	targets: [
		.executableTarget(
			name: "MakeAppIcons",
			dependencies: [
				.product(name: "ArgumentParser", package: "swift-argument-parser"),
			]
		),
	]
)

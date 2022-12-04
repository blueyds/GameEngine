// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GameEngine",
	platforms: [
		.macOS(.v10_15),
		.iOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library( name: "GameEngine", targets: [
			"GameEngine"])   ],
    dependencies: [],
    targets: [
        .target(name: "GameEngine"),
        .testTarget( name: "GameEngineTests",
					 dependencies: ["GameEngine"])
    ]
)

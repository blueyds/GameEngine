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
			"MetalEngine",
			"GameObjects",
			"GameUtilities",
			"GameInput",
			"GameMeshes",
			"GameScene",
			"GameComponents"])   ],
    dependencies: [],
    targets: [
        .target(name: "MetalEngine"),
		.target(name: "GameObjects",
				dependencies: ["GameUtilities"]),
		.target(name: "GameUtilities"),
		.target(name: "GameInput"),
		.target(name: "GameMeshes",
				dependencies: [
					"MetalEngine",
					"GameObjects",
					"GameComponents"]),
		.target(name: "GameComponents",
				dependencies: ["GameObjects"]),
		.target(name: "GameScene",
				dependencies: [
					"GameObjects",
					"GameMeshes",
					"GameComponents",
					"MetalEngine"]),
        .testTarget( name: "GameEngineTests",
					 dependencies: ["MetalEngine"])
    ]
)

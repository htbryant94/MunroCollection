// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "XDesign",
    dependencies: [
        .package(
            url: "https://github.com/Quick/Quick",
            from: "3.1.2"
        ),
        .package(
            url: "https://github.com/Quick/Nimble",
            from: "9.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Shared",
            dependencies: []),
        .target(
            name: "XDesign",
            dependencies: ["Shared"]),
        .testTarget(
            name: "XDesignTests",
            dependencies: ["Shared", "Quick", "Nimble"]),
    ]
)

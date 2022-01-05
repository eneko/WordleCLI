// swift-tools-version:5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "wordle",
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(name: "Rainbow", url: "https://github.com/onevcat/rainbow", from: "4.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .executableTarget(
            name: "wordle",
            dependencies: ["Rainbow"]),
        .testTarget(
            name: "wordleTests",
            dependencies: ["wordle"]),
    ]
)

// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "Gorush",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .library(name: "Gorush", targets: ["Gorush"])
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0")
    ],
    targets: [
        .target(name: "Gorush", dependencies: ["Vapor"]),
        .testTarget(name: "GorushTests", dependencies: ["Gorush"])
    ]
)

// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "Gorush",
    products: [
        .library(name: "Gorush", targets: ["Gorush"])
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0")
    ],
    targets: [
        .target(name: "Gorush", dependencies: ["Vapor"]),
        .testTarget(name: "GorushTests", dependencies: ["Gorush"])
    ]
)

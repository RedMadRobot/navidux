//swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "Navidux",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "Navidux",
            targets: ["Navidux"]
        ),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "Navidux",
            dependencies: []
        ),
        .testTarget(
            name: "NaviduxTests",
            dependencies: ["Navidux"]
        ),
    ]
)

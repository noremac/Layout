// swift-tools-version:5.4

import PackageDescription

let package = Package(
    name: "Layout",
    platforms: [
        .iOS(.v13),
        .tvOS(.v13)
    ],
    products: [
        .library(
            name: "Layout",
            targets: ["Layout"]
        )
    ],
    targets: [
        .target(
            name: "Layout",
            dependencies: []
        ),
        .testTarget(
            name: "LayoutTests",
            dependencies: ["Layout"]
        )
    ]
)

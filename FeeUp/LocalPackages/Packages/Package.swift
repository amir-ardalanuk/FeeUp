// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FeedPackages",
    platforms: [.iOS(.v16)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Domain",
            targets: ["Domain"]),
        .library(
            name: "Network",
            targets: ["Network"]),
        .library(
            name: "API",
            targets: ["API"]),
        .library(
            name: "Mocks",
            targets: ["Mocks"]),
        .library(
            name: "Persistence",
            targets: ["Persistence"]),
    ],
    dependencies: [
        .package(url: "https://github.com/MakeAWishFoundation/SwiftyMocky", from: "4.2.0"),
    ],
    targets: [
        .target(
            name: "Domain",
            dependencies: []),
        .testTarget(
            name: "DomainTests",
            dependencies: ["Domain"]),
        .target(
            name: "Network",
            dependencies: []),
        .testTarget(
            name: "NetworkTests",
            dependencies: ["Network", "SwiftyMocky", "Mocks"]),
        .target(
            name: "API",
            dependencies: ["Network", "Domain"],
            resources: [.process("Resources")]
        ),
        .testTarget(
            name: "APITests",
            dependencies: ["API", "Mocks", "SwiftyMocky"]),
        .target(
            name: "Mocks",
            dependencies: ["Network", "Domain", "API", "SwiftyMocky"]
        ),
        .target(
            name: "Persistence",
            dependencies: ["Domain"]
        ),
        .testTarget(
            name: "PersistenceTests",
            dependencies: ["Persistence", "Mocks", "SwiftyMocky"]),
    ]
)

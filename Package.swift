// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "Sasha",
    dependencies: [
        .package(url: "https://github.com/johnsundell/files.git", from: "1.0.0"),
        .package(url: "https://github.com/nsomar/Swiftline.git", from: "0.0.0"),
    ],
    targets: [
        .target(
            name: "Sasha",
            dependencies: ["SashaCore"]),
        .target(
            name: "SashaCore",
            dependencies: ["Files", "Swiftline"],
            path: "./Sources/SashaCore"),
    ]
)

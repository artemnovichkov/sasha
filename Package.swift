// swift-tools-version:3.1

import PackageDescription

let package = Package(
    name: "Sasha",
    targets: [
        Target(
            name: "Sasha",
            dependencies: ["SashaCore"]
        ),
        Target(name: "SashaCore")
    ]
)

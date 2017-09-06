import PackageDescription

let package = Package(
    name: "Sasha",
    targets: [
        Target(
            name: "Sasha",
            dependencies: ["SashaCore"]
        ),
        Target(name: "SashaCore")
    ],
    dependencies: [
        .Package(url: "https://github.com/johnsundell/files.git", majorVersion: 1),
        .Package(url: "https://github.com/nsomar/Swiftline.git", majorVersion: 0)
    ]
)

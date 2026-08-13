// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "AELColorPicker",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .library(name: "AELColorKit", targets: ["AELColorKit"]),
        .executable(name: "AELColorPicker", targets: ["AELColorPicker"])
    ],
    targets: [
        .target(
            name: "AELColorKit",
            path: "Sources/AELColorKit"
        ),
        .executableTarget(
            name: "AELColorPicker",
            dependencies: ["AELColorKit"],
            path: "Sources/AELColorPicker"
        ),
        .testTarget(
            name: "AELColorKitTests",
            dependencies: ["AELColorKit"],
            path: "Tests/AELColorKitTests"
        )
    ]
)

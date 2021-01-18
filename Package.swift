// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "RomanNumeralFormatter",
    products: [
        .library(
            name: "RomanNumeralFormatter",
            targets: [
                "RomanNumeralFormatter"
            ]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/SlaunchaMan/IsNotEmpty.git",
            from: "0.0.1"
        )
    ],
    targets: [
        .target(
            name: "RomanNumeralFormatter",
            dependencies: [
                "IsNotEmpty"
            ]
        ),
        .testTarget(
            name: "RomanNumeralFormatterTests",
            dependencies: [
                "RomanNumeralFormatter"
            ]
        ),
        .testTarget(
            name: "RomanNumeralFormatterObjCTests",
            dependencies: [
                "RomanNumeralFormatter"
            ]
        ),
    ]
)

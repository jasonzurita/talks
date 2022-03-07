// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "Modules",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v15),
    ],
    products: [
        .library(
            name: "MTWorld",
            targets: ["MTWorld"]
        ),
        .library(
            name: "MTLocationClient",
            targets: ["MTLocationClient"]
        ),
        .library(
            name: "MTSummaryFeature",
            targets: ["MTSummaryFeature"]
        ),
        .library(
            name: "MTPermissionsFeature",
            targets: ["MTPermissionsFeature"]
        ),
        .library(
            name: "MTApp",
            targets: ["MTApp"]
        ),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "MTLanguage",
            dependencies: [],
            path: "Modules/Language/src"

        ),
        .target(
            name: "MTWorld",
            dependencies: [
                "MTLanguage",
                "MTLocationClient",
            ],
            path: "Modules/World/src"
        ),
        .target(
            name: "MTLocationClient",
            dependencies: [],
            path: "Modules/LocationClient/src"

        ),
        .target(
            name: "MTApp",
            dependencies: [
                "MTSummaryFeature",
                "MTPermissionsFeature",
            ],
            path: "Modules/App/src"
        ),
        .testTarget(
            name: "MTAppTests",
            dependencies: [
                "MTApp",
                "MTLocationClient",
            ],
            path: "Modules/App/Tests",
            exclude: ["__Snapshots__"]
        ),
        .target(
            name: "MTSummaryFeature",
            dependencies: [
                "MTLanguage",
                "MTWorld",
            ],
            path: "Modules/Features/SummaryFeature/src",
            resources: [
                .process("Resources"),
            ]
        ),
        .testTarget(
            name: "MTSummaryFeatureTests",
            dependencies: [
                "MTSummaryFeature",
            ],
            path: "Modules/Features/SummaryFeature/Tests",
            exclude: ["__Snapshots__"]
        ),
        .target(
            name: "MTPermissionsFeature",
            dependencies: [
                "MTLanguage",
                "MTWorld",
            ],
            path: "Modules/Features/PermissionsFeature/src",
            resources: [
                .process("Resources"),
            ]
        ),
        .testTarget(
            name: "MTPermissionsFeatureTests",
            dependencies: [
                "MTPermissionsFeature",
            ],
            path: "Modules/Features/PermissionsFeature/Tests",
            exclude: ["__Snapshots__"]
        ),
    ]
)

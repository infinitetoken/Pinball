// swift-tools-version:5.1
//
//  Package.swift
//  Pinball
//
//  Created by Aaron Wright on 7/16/19.
//  Copyright © 2019 Infinite Token LLC. All rights reserved.
//

import PackageDescription

let package = Package(
    name: "Pinball",
    platforms: [
        .macOS(.v10_12),
        .iOS(.v10),
        .tvOS(.v10),
        .watchOS(.v3)
    ],
    products: [
        .library(
            name: "Pinball",
            targets: ["Pinball"])
    ],
    targets: [
        .target(
            name: "Pinball",
            path: "Sources"),
        .testTarget(
            name: "PinballTests",
            dependencies: ["Pinball"],
            path: "Tests"),
    ]
)

// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "FirebaseDependency",
  platforms: [.iOS(.v15), .macOS(.v12)],
  products: [
    // Products define the executables and libraries a package produces, and make them visible to
    // other packages.
    .library(
      name: "FirebaseAnalyticsDependency",
      targets: ["FirebaseAnalyticsDependency"]
    ),
    .library(
      name: "FirebaseAnalyticsDependencyLive",
      targets: ["FirebaseAnalyticsDependencyLive"]
    ),
    .library(
      name: "FirebaseRemoteConfigurationDependency",
      targets: ["FirebaseRemoteConfigurationDependency"]
    ),
    .library(
      name: "FirebaseRemoteConfigurationDependencyLive",
      targets: ["FirebaseRemoteConfigurationDependencyLive"]
    ),
  ],
  dependencies: [
    .package(url: "https://github.com/firebase/firebase-ios-sdk.git", from: "10.4.0"),
    .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "0.1.4"),
  ],
  targets: [
    .target(
      name: "FirebaseAnalyticsDependency",
      dependencies: [
        .product(name: "Dependencies", package: "swift-dependencies")
      ]
    ),
    .target(
      name: "FirebaseAnalyticsDependencyLive",
      dependencies: [
        "FirebaseAnalyticsDependency",
        .product(name: "FirebaseAnalytics", package: "firebase-ios-sdk"),
      ]
    ),
    .target(
      name: "FirebaseRemoteConfigurationDependency",
      dependencies: [
        .product(name: "Dependencies", package: "swift-dependencies")
      ]
    ),
    .target(
      name: "FirebaseRemoteConfigurationDependencyLive",
      dependencies: [
        "FirebaseRemoteConfigurationDependency",
        .product(name: "FirebaseRemoteConfig", package: "firebase-ios-sdk"),
      ]
    ),
    .testTarget(
      name: "FirebaseAnalyticsDependencyTests",
      dependencies: ["FirebaseAnalyticsDependencyLive"]
    ),
    .testTarget(
      name: "FirebaseRemoteConfigurationDependencyTests",
      dependencies: ["FirebaseRemoteConfigurationDependencyLive"]
    ),
  ]
)

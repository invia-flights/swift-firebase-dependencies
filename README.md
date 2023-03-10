# Firebase Dependencies

![CI](https://github.com/invia-flights/swift-firebase-dependencies/actions/workflows/ci.yml/badge.svg) [![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Finvia-flights%2Fswift-firebase-dependencies%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/invia-flights/swift-firebase-dependencies) [![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Finvia-flights%2Fswift-firebase-dependencies%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/invia-flights/swift-firebase-dependencies)

Firebase Dependencies brings [`Dependencies`](https://github.com/pointfreeco/swift-dependencies) support to Firebase’s iOS SDK. It includes libraries for Remote
Configuration and Analytics, with more features coming soon.

## Motivation

The main motivation behind this package is supporting [`Dependencies`](https://github.com/pointfreeco/swift-dependencies). At
[Invia Flights](https://www.invia.de/en/careers/), we’re big fans of [Stephen and Brandon’s work](https://pointfree.co), and we’re
convinced that `Dependencies` is going to turn into the Swift de-facto standard
for managing dependencies.

We also wanted to solve a specific problem: importing 
Firebase systematically breaks SwiftUI previews. By segregating interface and
implementation —only the latter requires the original Firebase—, this 
package provides you with a clean workaround. 

## Usage

If you want to use Firebase Dependencies in a [SwiftPM](https://swift.org/package-manager/) project, it's as
simple as adding it to your `Package.swift`:

``` swift
dependencies: [
  .package(url: "https://github.com/invia-flights/swift-firebase-dependencies", from: "10.4.0")
]
```

And then adding the product to any target that needs access to the individual libraries:

```swift
.product(name: "FirebaseRemoteConfiguration", package: "swift-firebase-dependencies"),
.product(name: "FirebaseRemoteConfigurationLive", package: "swift-firebase-dependencies"),
```

## License

This package is released under the MIT license. See [LICENSE](LICENSE) for details.

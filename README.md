<p align="center">
    <img src="Assets/Marketing/logo.png"
      width=600>
</p>

<p align="center">
    <a href="https://github.com/LinkAndreas/Aphrodite/releases">
        <img src="https://img.shields.io/badge/Version-1.1-003049.svg"
             alt="Version: 1.1">
    </a>
    <img src="https://img.shields.io/badge/Swift-5.3-D62828.svg"
         alt="Swift: 5.3">
    <img src="https://img.shields.io/badge/Platforms-%20macOS-F77F00.svg"
        alt="Platforms: iOS">
    <a href="https://github.com/LinkAndreas/Aphrodite/blob/stable/LICENSE.md">
        <img src="https://img.shields.io/badge/License-MIT-FCBF49.svg"
              alt="License: MIT">
    </a>
</p>

<p align="center">
  • <a href="#motivation">Motivation</a>
  • <a href="#architecture">Architecture</a>
  • <a href="#credits">Credits</a>
  • <a href="#license">License</a>
  • <a href="https://github.com/LinkAndreas/Licenses/issues">Issues</a>
</p>

# Licenses

Have you ever been asked to put together the list of licenses of all frameworks that are used within your iOS, iPad OS, or macOS app? Manually completing this task quickly becomes tedious but may be required due to legal- or customer requests.

To mitigate this issue, I developed **Licenses**, a native macOS app that automates this procedure by collecting and exporting your licenses into a single spreadsheet (CSV) file.

You can check out the latest version of *Licenses* in the Mac AppStore ([Link](https://apps.apple.com/us/app/licenses/id1545822966))

<div>
<img src="Assets/Marketing/Composition.png" alt="drawing" style="display: block; margin: 16pt auto 16pt auto; width: 95%; max-width: 500pt;"/>
<p style="text-align: center; max-width: 75%; margin: auto; font-size: 75%;">Apple, the Apple logo, iPhone, and iPad are trademarks of Apple Inc., registered in the U.S. and other countries. App Store is a service mark of Apple Inc., registered in the U.S. and other countries.</p>
</div>

## Motivation

This project aims to explore the capabilities of Swift UI on the Mac and to examine whether both Swift UI and Combine are ready to be used in production. I have documented the steps that I took as well as the challenges that I faced when building the project in the following article:

- [Article.md](article.md)

## Architecture

*Licenses*, uses a redux-inspired architecture, as illustrated below, consisting of Data-, Bloc-, ViewStore- and UI-related components. This way, state changes only occur within the bloc's reducer function, transforming incoming actions as well as the current state to an updated state that is ultimately consumed by the UI.

<img src="Assets/Documentation/Architecture.png" alt="drawing" style="display: block; margin: 16pt auto 16pt auto; width: 95%; max-width: 500pt;"/>

Also, side effects are performed by returning publishers from the reducer resulting in additional actions that are sent to the bloc. Hence, asynchronous work is treated similarly to synchronous work in the way that it only affects the state from within the reducer. Thus, the correctness of the reducer and as such the correctness of all state changes becomes testable through unit tests.

Note that blocs are not directly connected to the UI, but rather via view stores that act as the main communication gateway of the view. As a result, domain-specific knowledge is not exposed, but rather gets translated into view-specific models that only include the formatted data that is ready to be shown in the UI. As an example, instead of passing repositories, i.e.,  `[GitHubRepository]`, to the view directly, we can rather pass a list of items, i.e., `[ListItem]`, where each item only consists of UI-related data (e.g., `title` or `subtitle`) and omits any internal data that is repository-specific. Similarly, view actions are translated into domain-specific actions that are forwarded by the view store to the bloc. Excluding business- and domain-specific knowledge out of the view keeps them lean and facilitates simplified previews using mock data in Xcode.

## Credits

- LicensePlist - Masayuki Ono ([Reference](https://github.com/mono0926/LicensePlist))
- The Composable Architecture - Point-Free] ([Reference](https://github.com/pointfreeco/swift-composable-architecture))
- Redux like state Containers in SwiftUI - Swift with Majid ([Reference](https://swiftwithmajid.com/2019/09/18/redux-like-state-container-in-swiftui/))

## License

This project is released under the [MIT License](http://opensource.org/licenses/MIT). See LICENSE for details.
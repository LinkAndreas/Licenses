// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Licenses
  internal static let appName = L10n.tr("Localizable", "app_name")

  internal enum Csv {
    internal enum Header {
      internal enum Author {
        /// Author
        internal static let title = L10n.tr("Localizable", "csv.header.author.title")
      }
      internal enum LicenseContent {
        /// License Content
        internal static let title = L10n.tr("Localizable", "csv.header.license_content.title")
      }
      internal enum LicenseName {
        /// License Name
        internal static let title = L10n.tr("Localizable", "csv.header.license_name.title")
      }
      internal enum LicenseUrl {
        /// License URL
        internal static let title = L10n.tr("Localizable", "csv.header.license_url.title")
      }
      internal enum Name {
        /// Name
        internal static let title = L10n.tr("Localizable", "csv.header.name.title")
      }
      internal enum PackageManager {
        /// Package Manager
        internal static let title = L10n.tr("Localizable", "csv.header.package_manager.title")
      }
      internal enum Version {
        /// Version
        internal static let title = L10n.tr("Localizable", "csv.header.version.title")
      }
    }
  }

  internal enum Detail {
    /// You can import manifests using the import button at the top right corner. Alternatively, you can drag them onto this window. The following manifests are supported:
    internal static let placeholder = L10n.tr("Localizable", "detail.placeholder")
    internal enum ListEntry {
      internal enum Author {
        /// Author:
        internal static let title = L10n.tr("Localizable", "detail.list_entry.author.title")
      }
      internal enum LicenseContent {
        /// License Content:
        internal static let title = L10n.tr("Localizable", "detail.list_entry.license_content.title")
      }
      internal enum LicenseName {
        /// License Name:
        internal static let title = L10n.tr("Localizable", "detail.list_entry.license_name.title")
      }
      internal enum LicenseUrl {
        /// License URL:
        internal static let title = L10n.tr("Localizable", "detail.list_entry.license_url.title")
      }
      internal enum Name {
        /// Name:
        internal static let title = L10n.tr("Localizable", "detail.list_entry.name.title")
      }
      internal enum PackageManager {
        /// Package Manager:
        internal static let title = L10n.tr("Localizable", "detail.list_entry.package_manager.title")
      }
      internal enum Version {
        /// Version:
        internal static let title = L10n.tr("Localizable", "detail.list_entry.version.title")
      }
    }
    internal enum Placeholder {
      internal enum Examples {
        /// You can try out Licenses using the example manifest below:
        internal static let title = L10n.tr("Localizable", "detail.placeholder.examples.title")
        internal enum Button {
          /// Import Example Manifest
          internal static let title = L10n.tr("Localizable", "detail.placeholder.examples.button.title")
        }
      }
      internal enum SupportedManifests {
        internal enum Carthage {
          /// • Carthage: "Cartfile.resolved"
          internal static let title = L10n.tr("Localizable", "detail.placeholder.supported_manifests.carthage.title")
        }
        internal enum Cocoapods {
          /// • CocoaPods: "Podfile.lock"
          internal static let title = L10n.tr("Localizable", "detail.placeholder.supported_manifests.cocoapods.title")
        }
        internal enum SwiftPm {
          /// • SwiftPm: "Package.resolved"
          internal static let title = L10n.tr("Localizable", "detail.placeholder.supported_manifests.swift_pm.title")
        }
      }
    }
  }

  internal enum Error {
    /// GitHub Request limit exceeded. Please try again later or add a personal access token in preferences to increase your rate limit.
    internal static let githubRateLimitExceeded = L10n.tr("Localizable", "error.github_rate_limit_exceeded")
    /// Unauthorized, please verify your personal access token in preferences.
    internal static let unauthorized = L10n.tr("Localizable", "error.unauthorized")
  }

  internal enum Master {
    /// Made by Andreas Link in Karlsruhe
    internal static let placeholder = L10n.tr("Localizable", "master.placeholder")
  }

  internal enum Panel {
    internal enum Open {
      /// Source
      internal static let title = L10n.tr("Localizable", "panel.open.title")
    }
    internal enum Save {
      /// licenses.csv
      internal static let filename = L10n.tr("Localizable", "panel.save.filename")
      /// Destination
      internal static let title = L10n.tr("Localizable", "panel.save.title")
    }
  }

  internal enum Settings {
    /// Settings
    internal static let title = L10n.tr("Localizable", "settings.title")
    internal enum Tabs {
      internal enum General {
        /// General
        internal static let title = L10n.tr("Localizable", "settings.tabs.general.title")
        internal enum AutomaticLicenseSearch {
          /// Automatic License Search
          internal static let title = L10n.tr("Localizable", "settings.tabs.general.automatic_license_search.title")
        }
      }
      internal enum Token {
        /// You can add your personal access token to get an increased rate limit for the GitHub API.
        internal static let description = L10n.tr("Localizable", "settings.tabs.token.description")
        /// Please enter your personal access token
        internal static let placeholder = L10n.tr("Localizable", "settings.tabs.token.placeholder")
        /// Github Token
        internal static let title = L10n.tr("Localizable", "settings.tabs.token.title")
      }
    }
  }

  internal enum Toolbar {
    internal enum ExportLicenses {
      /// Export Licenses
      internal static let tooltip = L10n.tr("Localizable", "toolbar.export_licenses.tooltip")
    }
    internal enum FetchLicenses {
      /// Fetch Licenses
      internal static let tooltip = L10n.tr("Localizable", "toolbar.fetch_licenses.tooltip")
    }
    internal enum ImportManifests {
      /// Import Manifests
      internal static let tooltip = L10n.tr("Localizable", "toolbar.import_manifests.tooltip")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type

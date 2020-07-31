//  Copyright © 2020 Andreas Link. All rights reserved.

import Foundation

struct Manifest: Equatable {
    var packageManager: PackageManager
    var content: String
    var filePath: URL

    init?(fromFilePath filePath: URL) {
        switch filePath.lastPathComponent {
        case "Cartfile.resolved":
            self.packageManager = .carthage

        case "Podfile.lock":
            self.packageManager = .cocoaPods

        case "Package.resolved":
            self.packageManager = .swiftPm

        default:
            return nil
        }

        guard let content = try? String(contentsOf: filePath, encoding: .utf8) else { return nil }

        self.content = content
        self.filePath = filePath
    }
}

//  Copyright © 2020 Andreas Link. All rights reserved.

import Foundation

enum ArtifactType: CaseIterable {
    case carthage
    case swiftPm

    init?(fromFileName fileName: String) {
        switch fileName {
        case "Cartfile.resolved":
            self = .carthage

        case "Package.resolved":
            self = .swiftPm

        default:
            return nil
        }
    }

    var fileName: String {
        switch self {
        case .carthage:
            return "Cartfile.resolved"

        case .swiftPm:
            return "Package.resolved"
        }
    }
}

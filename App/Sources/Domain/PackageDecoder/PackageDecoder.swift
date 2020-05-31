//  Copyright © 2020 Andreas Link. All rights reserved.

import Combine

enum PackageDecoder {
    static func decode(from manifests: [Manifest]) -> Packages {
        return manifests.reduce(.init()) { packages, artefact in
            var packages = packages

            switch artefact.packageManager {
            case .carthage:
                packages.carthagePackages += CarthagePackageDecoder.decode(content: artefact.content)

            case .swiftPm:
                packages.swiftPmPackages += SwiftPmPackageDecoder.decode(content: artefact.content)

            case .cocoaPods:
                packages.cocoaPodsPackages += CocoaPodsPackageDecoder.decode(content: artefact.content)
            }

            return packages
        }
    }
}

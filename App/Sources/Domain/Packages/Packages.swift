//  Copyright © 2020 Andreas Link. All rights reserved.

struct Packages {
    var cocoaPodsPackages: [CocoaPodsPackage]
    var carthagePackages: [CarthagePackage]
    var swiftPmPackages: [SwiftPmPackage]

    init(
        cocoaPodsPackages: [CocoaPodsPackage] = [],
        carthagePackages: [CarthagePackage] = [],
        swiftPmPackages: [SwiftPmPackage] = []
    ) {
        self.cocoaPodsPackages = cocoaPodsPackages
        self.carthagePackages = carthagePackages
        self.swiftPmPackages = swiftPmPackages
    }
}

//  Copyright © 2020 Andreas Link. All rights reserved.

import Foundation

struct SwiftPmPackage: Decodable, Equatable {
    struct State: Decodable, Equatable {
        let branch: String?
        let revision: String?
        let version: String?
    }

    let package: String
    let repositoryURL: String
    let state: State
}

struct ResolvedPackages: Decodable {
    struct Pins: Decodable {
        let pins: [SwiftPmPackage]
    }

    let object: Pins
    let version: Int
}

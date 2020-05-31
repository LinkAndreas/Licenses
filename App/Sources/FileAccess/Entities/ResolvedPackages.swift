//  Copyright © 2020 Andreas Link. All rights reserved.

struct ResolvedPackages: Decodable {
    let object: Pins
    let version: Int
}

extension ResolvedPackages {
    enum CodingKeys: String, CodingKey {
        case object
        case version
    }
}

struct Pins: Decodable {
    let pins: [Pin]
}

extension Pins {
    enum CodingKeys: String, CodingKey {
        case pins
    }
}

struct Pin: Decodable, Equatable {
    struct State: Decodable, Equatable {
        let branch: String?
        let revision: String?
        let version: String?
    }

    let package: String
    let repositoryUrl: String
    let state: State
}

extension Pin {
    enum CodingKeys: String, CodingKey {
        case package
        case repositoryUrl = "repositoryURL"
        case state
    }
}

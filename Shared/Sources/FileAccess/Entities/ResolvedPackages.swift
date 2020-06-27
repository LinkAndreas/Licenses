//  Copyright © 2020 Andreas Link. All rights reserved.

struct ResolvedPackages: Decodable {
    struct Pins: Decodable {
        struct Pin: Decodable, Equatable {
            struct State: Decodable, Equatable {
                let branch: String?
                let revision: String?
                let version: String
            }

            let package: String
            let repositoryUrl: String
            let state: State

            enum CodingKeys: String, CodingKey {
                case package
                case repositoryUrl = "repositoryURL"
                case state
            }
        }

        let pins: [Pin]
    }

    let object: Pins
    let version: Int
}

//  Copyright © 2021 Andreas Link. All rights reserved.

struct PinEntity: Decodable, Equatable {
    let package: String
    let repositoryUrl: String
    let state: PinStateEntity

    enum CodingKeys: String, CodingKey {
        case package
        case repositoryUrl = "repositoryURL"
        case state
    }
}

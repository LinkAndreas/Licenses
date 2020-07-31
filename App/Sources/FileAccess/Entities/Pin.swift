//  Copyright © 2020 Andreas Link. All rights reserved.

struct Pin: Decodable, Equatable {
    let package: String
    let repositoryUrl: String
    let state: PinState

    enum CodingKeys: String, CodingKey {
        case package
        case repositoryUrl = "repositoryURL"
        case state
    }
}

//  Copyright © 2020 Andreas Link. All rights reserved.

import Foundation

struct GithubErrorResponseEntity: Codable {
    let message: String
    let documentationURL: String

    enum CodingKeys: String, CodingKey {
        case message = "message"
        case documentationURL = "documentation_url"
    }
}

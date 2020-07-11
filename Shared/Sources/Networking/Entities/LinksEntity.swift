//  Copyright © 2020 Andreas Link. All rights reserved.

import Foundation

struct LinksEntity: Codable {
    var linksSelf: String?
    var git: String?
    var html: String?

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case git = "git"
        case html = "html"
    }
}

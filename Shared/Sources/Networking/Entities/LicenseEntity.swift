//  Copyright © 2020 Andreas Link. All rights reserved.

import Foundation

struct LicenseEntity: Codable {
    var key: String?
    var name: String?
    var spdxID: String?
    var url: String?
    var nodeID: String?

    enum CodingKeys: String, CodingKey {
        case key = "key"
        case name = "name"
        case spdxID = "spdx_id"
        case url = "url"
        case nodeID = "node_id"
    }
}

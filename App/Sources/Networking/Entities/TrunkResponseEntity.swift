//  Copyright © 2021 Andreas Link. All rights reserved.

import Foundation

struct TrunkResponseEntity: Codable {
    let dataURL: String
}

extension TrunkResponseEntity {
    enum CodingKeys: String, CodingKey {
        case dataURL = "data_url"
    }
}

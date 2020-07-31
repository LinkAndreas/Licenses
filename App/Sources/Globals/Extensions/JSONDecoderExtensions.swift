//  Copyright © 2020 Andreas Link. All rights reserved.

import Foundation

extension JSONDecoder {
    static let `default`: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dataDecodingStrategy = .base64
        decoder.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            let dateInt = try container.decode(Int64.self)

            return Date(timeIntervalSince1970: TimeInterval(dateInt) / 1_000)
        }

        return decoder
    }()
}

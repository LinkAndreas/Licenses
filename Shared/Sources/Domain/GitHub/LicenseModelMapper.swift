//  Copyright © 2020 Andreas Link. All rights reserved.

import Foundation

enum LicenseModelMapper {
    static func map(from entity: LicenseEntity?) -> License? {
        guard let entity = entity else { return nil }

        return .init(
            key: entity.key,
            name: entity.name,
            spdxID: entity.spdxID,
            url: entity.url,
            nodeID: entity.nodeID
        )
    }
}

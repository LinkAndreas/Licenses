//  Copyright © 2020 Andreas Link. All rights reserved.

import Foundation

enum LinksModelMapper {
    static func map(from entity: LinksEntity?) -> Links? {
        guard let entity = entity else { return nil }

        return .init(
            linksSelf: entity.linksSelf,
            git: entity.git,
            html: entity.html
        )
    }
}

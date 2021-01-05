//  Copyright © 2021 Andreas Link. All rights reserved.

import Foundation

enum TrunkResponseModelMapper {
    static func map(from entity: TrunkResponseEntity) -> TrunkResponse? {
        guard let url: URL = URL(string: entity.dataURL) else { return nil }

        return TrunkResponse(dataURL: url)
    }
}

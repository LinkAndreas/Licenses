//  Copyright © 2021 Andreas Link. All rights reserved.

struct PinStateEntity: Decodable, Equatable {
    let branch: String?
    let revision: String?
    let version: String
}

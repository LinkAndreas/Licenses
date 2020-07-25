//  Copyright © 2020 Andreas Link. All rights reserved.

struct PinState: Decodable, Equatable {
    let branch: String?
    let revision: String?
    let version: String
}

//  Copyright © 2021 Andreas Link. All rights reserved.

import Combine

extension Publisher {
    func eraseToEffect() -> Effect<Output, Failure> {
        Effect(self)
    }
}

//  Copyright © 2021 Andreas Link. All rights reserved.

import Foundation

extension String {
    func removing(suffix: String) -> String {
        guard self.hasSuffix(suffix) else { return self }

        return String(self.dropLast(suffix.count))
    }
}

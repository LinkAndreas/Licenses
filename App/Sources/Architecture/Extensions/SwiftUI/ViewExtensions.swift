//  Copyright © 2021 Andreas Link. All rights reserved.

import SwiftUI

extension View {
    func eraseToAnyView() -> AnyView {
        return .init(self)
    }
}

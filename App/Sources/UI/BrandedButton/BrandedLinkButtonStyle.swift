//  Copyright © 2020 Andreas Link. All rights reserved.

import SwiftUI

struct BrandedLinkButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled: Bool

    func makeBody(configuration: ButtonStyle.Configuration) -> some View {
        configuration.label
            .foregroundColor(Color(NSColor.textColor))
            .opacity(isEnabled ? configuration.isPressed ? 0.5 : 1.0 : 0.4)
    }
}

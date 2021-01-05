//  Copyright © 2021 Andreas Link. All rights reserved.

import SwiftUI

struct BrandedButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled: Bool

    func makeBody(configuration: ButtonStyle.Configuration) -> some View {
        configuration.label
            .padding()
            .foregroundColor(Color(Asset.Colors.light.color))
            .background(
                Capsule()
                    .fill(Color.accentColor.opacity(configuration.isPressed ? 0.6 : 0.5))
            )
            .overlay(
                Capsule()
                    .stroke(Color.accentColor, lineWidth: 2)
            )
            .opacity(isEnabled ? 1.0 : 0.4)
    }
}

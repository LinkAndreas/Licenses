//  Copyright © 2020 Andreas Link. All rights reserved.

import SwiftUI

struct BrandedButtonStyle: ButtonStyle {
    func makeBody(configuration: ButtonStyle.Configuration) -> some View {
        MyButton(configuration: configuration)
    }

    private struct MyButton: View {
        let configuration: ButtonStyle.Configuration

        @Environment(\.isEnabled) private var isEnabled: Bool

        var body: some View {
            configuration.label
                .padding()
                .foregroundColor(Color(Asset.Colors.light.color))
                .background(
                    Capsule()
                        .fill(Color(Asset.Colors.light.color).opacity(configuration.isPressed ? 0.6 : 0.3))
                )
                .overlay(
                    Capsule()
                        .stroke(Color(Asset.Colors.light.color), lineWidth: 1.5)
                )
                .opacity(isEnabled ? 1.0 : 0.4)
        }
    }
}

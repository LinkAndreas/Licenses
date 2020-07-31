//  Copyright © 2020 Andreas Link. All rights reserved.

import SwiftUI

struct IconButton: View {
    private struct CustomButtonStyle: ButtonStyle {
        func makeBody(configuration: Self.Configuration) -> some View {
            configuration.label
                .opacity(configuration.isPressed ? 0.2 : 1.0)
                .animation(.spring())
        }
    }

    let iconName: String
    let width: CGFloat
    let height: CGFloat
    let isDisabled: Bool
    let action: () -> Void

    init(
        iconName: String,
        width: CGFloat = 21,
        height: CGFloat = 21,
        isDisabled: Bool = false,
        action: @escaping () -> Void = {}
    ) {
        self.iconName = iconName
        self.width = width
        self.height = height
        self.isDisabled = isDisabled
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            Image(iconName)
                .resizable()
                .scaledToFit()
                .opacity(isDisabled ? 0.35 : 1)
                .frame(width: width, height: height)
        }
        .buttonStyle(CustomButtonStyle())
        .disabled(isDisabled)
    }
}

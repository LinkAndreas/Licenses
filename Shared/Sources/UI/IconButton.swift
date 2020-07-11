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
    let action: () -> Void

    init(iconName: String, width: CGFloat = 21, height: CGFloat = 21, action: @escaping () -> Void = {}) {
        self.iconName = iconName
        self.width = width
        self.height = height
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            Image(iconName)
                .resizable()
                .scaledToFit()
                .frame(width: width, height: height)
        }
        .buttonStyle(CustomButtonStyle())
    }
}

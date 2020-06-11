//  Copyright © 2020 Andreas Link. All rights reserved.

import AppKit
import SwiftUI

struct ActivityIndicator: NSViewRepresentable {
    @Binding var isAnimating: Bool
    let style: NSProgressIndicator.Style

    func makeNSView(context: Context) -> NSProgressIndicator {
        let indicator: NSProgressIndicator = .init()
        indicator.style = style
        return indicator
    }

    func updateNSView(_ nsView: NSProgressIndicator, context: Context) {
        nsView.style = style
        isAnimating ? nsView.startAnimation(nil) : nsView.stopAnimation(nil)
    }
}

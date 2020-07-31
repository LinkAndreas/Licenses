//  Copyright © 2020 Andreas Link. All rights reserved.

import Cocoa
import SwiftUI

struct ProgressIndicator: NSViewRepresentable {
    func makeNSView(context: Context) -> ProgressIndicatorView {
        ProgressIndicatorView()
    }

    func updateNSView(_ nsView: ProgressIndicatorView, context: Context) {
        return
    }
}

struct ProgressIndicator_Previews: PreviewProvider {
    static var previews: some View {
        ProgressIndicator()
            .previewLayout(.fixed(width: 15, height: 15))
    }
}

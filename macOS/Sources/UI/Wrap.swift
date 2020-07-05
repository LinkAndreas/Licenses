//  Copyright © 2020 Andreas Link. All rights reserved.

import Cocoa
import SwiftUI

struct Wrap<Wrapped: NSView>: NSViewRepresentable {
    typealias Updater = (Wrapped, Context) -> Void

    var makeView: () -> Wrapped
    var update: (Wrapped, Context) -> Void

    init(
        _ makeView: @escaping @autoclosure () -> Wrapped,
        updater update: @escaping Updater
    ) {
        self.makeView = makeView
        self.update = update
    }

    func makeNSView(context: Context) -> Wrapped {
        makeView()
    }

    func updateNSView(_ view: Wrapped, context: Context) {
        update(view, context)
    }
}

//  Copyright © 2020 Andreas Link. All rights reserved.

import Cocoa

extension NSView {
    /// Adds constraints to this `NSView` instances `superview` object to make sure
    /// this always has the same size as the superview. This has no effect if its `superview` is `nil`
    func bindEdgesToSuperview() {
        guard let superview = superview else {
            print(
                """
                    Error! `superview` was nil – call `addSubview(view: UIView)`
                    before calling `bindEdgesToSuperview()`.
                """
            )
            return
        }

        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
        leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
    }
}

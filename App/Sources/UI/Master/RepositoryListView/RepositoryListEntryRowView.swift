//  Copyright © 2020 Andreas Link. All rights reserved.

import AppKit

final class RepositoryListEntryRowView: NSTableRowView {
    override func drawSelection(in dirtyRect: NSRect) {
        guard selectionHighlightStyle != .none else { return }

        let selectionRect: NSRect = bounds.insetBy(dx: 10, dy: 0)
        Asset.Colors.selectionBackground.color.setStroke()
        Asset.Colors.selectionBackground.color.setFill()
        let path: NSBezierPath = .init(roundedRect: selectionRect, xRadius: 6, yRadius: 6)
        path.fill()
        path.stroke()
    }
}

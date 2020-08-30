//  Copyright © 2020 Andreas Link. All rights reserved.

import Cocoa

final class RepositoryListEntryRowView: NSTableRowView {
    override var isSelected: Bool {
        get { return super.isSelected }
        set {
            super.isSelected = newValue
            setNeedsDisplay(bounds)
        }
    }

    override func drawBackground(in dirtyRect: NSRect) {
        (isSelected ? NSColor.orange : NSColor.clear).set()
        dirtyRect.fill()
    }
}

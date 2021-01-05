//  Copyright © 2021 Andreas Link. All rights reserved.

import Cocoa
import SwiftUI

final class ProgressIndicatorView: NSView {
    private let progressIndicator: NSProgressIndicator = .init(frame: .zero)

    init() {
        super.init(frame: .zero)

        commonInit()
    }

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)

        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        commonInit()
    }

    private func commonInit() {
        setupProgressIndicator()
        setupLayout()
    }

    override func layout() {
        super.layout()

        progressIndicator.frame = frame
    }

    private func setupProgressIndicator() {
        progressIndicator.translatesAutoresizingMaskIntoConstraints = false
        progressIndicator.frame = frame
        progressIndicator.style = .spinning
        progressIndicator.startAnimation(nil)
    }

    private func setupLayout() {
        addSubview(progressIndicator)
    }
}

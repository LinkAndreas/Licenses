//  Copyright © 2020 Andreas Link. All rights reserved.

import Cocoa
import SwiftUI

struct TextLabel: NSViewControllerRepresentable {
    private let text: String
    private let textColor: NSColor
    private let font: NSFont
    private let alignment: NSTextAlignment
    private let isSelectable: Bool
    private let isEditable: Bool

    init(
        text: String,
        textColor: NSColor = .textColor,
        font: NSFont = .systemFont(ofSize: 14, weight: .regular),
        alignment: NSTextAlignment = .left,
        isSelectable: Bool = false,
        isEditable: Bool = false
    ) {
        self.text = text
        self.textColor = textColor
        self.font = font
        self.alignment = alignment
        self.isSelectable = isSelectable
        self.isEditable = isEditable
    }

    func makeNSViewController(
        context: NSViewControllerRepresentableContext<TextLabel>
    ) -> TextLabelController {
        return .init(
            text: text,
            textColor: textColor,
            font: font,
            alignment: alignment,
            isSelectable: isSelectable,
            isEditable: isEditable
        )
    }

    func updateNSViewController(
        _ nsViewController: TextLabelController,
        context: NSViewControllerRepresentableContext<TextLabel>
    ) {
        return
    }
}

final class TextLabelController: NSViewController {
    private let text: String
    private let textColor: NSColor
    private let font: NSFont
    private let alignment: NSTextAlignment
    private let isSelectable: Bool
    private let isEditable: Bool
    private let textField: NSTextField = .init()

    init(
        text: String,
        textColor: NSColor,
        font: NSFont,
        alignment: NSTextAlignment,
        isSelectable: Bool,
        isEditable: Bool
    ) {
        self.text = text
        self.textColor = textColor
        self.font = font
        self.alignment = alignment
        self.isSelectable = isSelectable
        self.isEditable = isEditable

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = NSView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTextField()
        setupLayout()
    }

    private func setupTextField() {
        textField.stringValue = text
        textField.isBordered = false
        textField.focusRingType = .none
        textField.textColor = .white
        textField.drawsBackground = false
        textField.backgroundColor = .clear
        textField.isSelectable = isSelectable
        textField.isEditable = isEditable
        textField.alignment = alignment
        textField.font = font
        textField.maximumNumberOfLines = 0
        textField.lineBreakMode = .byWordWrapping
    }

    private func setupLayout() {
        view.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        textField.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        textField.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        textField.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

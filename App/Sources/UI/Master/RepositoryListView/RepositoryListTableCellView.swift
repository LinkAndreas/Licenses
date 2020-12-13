//  Copyright © 2020 Andreas Link. All rights reserved.

import AppKit
import SwiftUI

final class RepositoryListTableCellView: NSTableCellView {
    private let entry: RepositoryListEntry
    private var isEmphasized: Bool = false

    override var backgroundStyle: NSView.BackgroundStyle {
        get { .normal }
        set {
            isEmphasized = newValue == .emphasized
            updateViewModel()
        }
    }

    private let contentStackView: NSStackView = .init(frame: .zero)
    private let verticalStackView: NSStackView = .init(frame: .zero)
    private let progressIndicator: NSProgressIndicator = .init(frame: .zero)
    private let titleTextField: NSTextField = .init(frame: .zero)
    private let subtitleTextField: NSTextField = .init(frame: .zero)
    private let captionTextField: NSTextField = .init(frame: .zero)

    init(entry: RepositoryListEntry) {
        self.entry = entry

        super.init(frame: .zero)

        commonInit()
    }

    @available(*, unavailable)
    override init(frame frameRect: NSRect) {
        fatalError("unavailable")
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("unavailable")
    }

    private func commonInit() {
        setupProgressIndicator()
        setupTextFields()
        setupStackViews()
        setupLayout()
        updateViewModel()
    }

    private func setupProgressIndicator() {
        progressIndicator.style = .spinning
        progressIndicator.startAnimation(nil)
    }

    private func setupTextFields() {
        titleTextField.backgroundColor = .clear
        titleTextField.isEditable = false
        titleTextField.isBezeled = false
        titleTextField.font = .preferredFont(forTextStyle: .headline)

        subtitleTextField.backgroundColor = .clear
        subtitleTextField.isEditable = false
        subtitleTextField.isBezeled = false
        subtitleTextField.font = .preferredFont(forTextStyle: .subheadline)

        captionTextField.backgroundColor = .clear
        captionTextField.isEditable = false
        captionTextField.isBezeled = false
        captionTextField.font = .preferredFont(forTextStyle: .callout)
    }

    private func setupStackViews() {
        verticalStackView.orientation = .vertical
        verticalStackView.distribution = .fill
        verticalStackView.alignment = .leading

        contentStackView.orientation = .horizontal
        contentStackView.distribution = .fill
        contentStackView.alignment = .centerY
    }

    private func setupLayout() {
        addSubview(contentStackView)
        contentStackView.addArrangedSubview(progressIndicator)
        contentStackView.addArrangedSubview(verticalStackView)
        verticalStackView.addArrangedSubview(titleTextField)
        verticalStackView.addArrangedSubview(subtitleTextField)
        contentStackView.addArrangedSubview(captionTextField)

        progressIndicator.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            progressIndicator.widthAnchor.constraint(equalToConstant: 15),
            progressIndicator.heightAnchor.constraint(equalToConstant: 15),
            contentStackView.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6),
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4)
        ])
    }

    private func updateViewModel() {
        progressIndicator.isHidden = !entry.showsProgressIndicator

        titleTextField.stringValue = entry.title ?? ""
        subtitleTextField.stringValue = entry.subtitle ?? ""
        captionTextField.stringValue = entry.caption ?? ""

        titleTextField.isHidden = entry.title == nil
        subtitleTextField.isHidden = entry.subtitle == nil
        captionTextField.isHidden = entry.caption == nil

        titleTextField.textColor = isEmphasized ? .alternateSelectedControlTextColor : .labelColor
        subtitleTextField.textColor = isEmphasized ? .alternateSelectedControlTextColor : .secondaryLabelColor
        captionTextField.textColor = isEmphasized ? .alternateSelectedControlTextColor : .secondaryLabelColor
    }
}

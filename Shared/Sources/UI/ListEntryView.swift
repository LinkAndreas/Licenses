//  Copyright © 2020 Andreas Link. All rights reserved.

import Cocoa

final class ListEntryView: NSView {
    var viewModel: ListEntryViewModel? {
        didSet { updateUI() }
    }

    private let stackView: NSStackView = .init(frame: .zero)
    private let titleTextField: NSTextField = .init(frame: .zero)
    private let detailTextField: NSTextField = .init(frame: .zero)
    private let progressIndicator: NSProgressIndicator = .init(frame: .zero)

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)

        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        commonInit()
    }

    private func commonInit() {
        setupUI()
    }

    private func setupUI() {
        setupStackView()
        setupTextFields()
        setupLayout()
    }

    private func setupStackView() {
        stackView.distribution = .gravityAreas
        stackView.orientation = .horizontal
        stackView.alignment = .centerY
    }

    private func setupTextFields() {
        titleTextField.isEditable = false
        detailTextField.isEditable = false

        titleTextField.isBezeled = false
        detailTextField.isBezeled = false

        titleTextField.backgroundColor = .clear
        detailTextField.backgroundColor = .clear

        titleTextField.font = .systemFont(ofSize: 16, weight: .medium)
        detailTextField.font = .systemFont(ofSize: 12, weight: .regular)
    }

    private func setupProgressIndicators() {
        progressIndicator.style = .spinning
    }

    private func setupLayout() {
        addSubview(stackView)
        stackView.addArrangedSubview(progressIndicator)
        stackView.addArrangedSubview(titleTextField)
        stackView.addArrangedSubview(detailTextField)

        stackView.translatesAutoresizingMaskIntoConstraints = false

        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    }

    private func updateUI() {
        titleTextField.stringValue = viewModel?.entry?.title ?? ""
        detailTextField.stringValue = viewModel?.entry?.detail ?? ""
        progressIndicator.isHidden = viewModel?.entry?.isProcessing != true
    }
}

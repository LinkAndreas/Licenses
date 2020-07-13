//  Copyright © 2020 Andreas Link. All rights reserved.

import Cocoa
import Combine

final class Toolbar: NSObject {
    static let shared: Toolbar = .init()
    
    let wrappedToolbar: NSToolbar = .init(identifier: "de.linkandreas.licenses.toolbar")

    private var cancellables: Set<AnyCancellable> = []
    private let fetchButton: NSButton = .init(image: .fetchIcon, target: nil, action: nil)
    private let exportButton: NSButton = .init(image: .shareIcon, target: nil, action: nil)

    override init() {
        super.init()

        setupToolbar()
        setupBindings()
    }

    private func setupToolbar() {
        wrappedToolbar.delegate = self
        wrappedToolbar.displayMode = .iconAndLabel
    }

    private func setupBindings() {
        Store.shared.$isProcessing.sink { [weak self] isProcessing in
            self?.fetchButton.isEnabled = !isProcessing
            self?.exportButton.isEnabled = !isProcessing
        }
        .store(in: &cancellables)
    }
}

extension Toolbar: NSToolbarDelegate {
    func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        [.fetchLicenses, .exportLicenses]
    }

    func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        [.fetchLicenses, .exportLicenses]
    }

    func toolbar(
        _ toolbar: NSToolbar,
        itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier,
        willBeInsertedIntoToolbar flag: Bool
    ) -> NSToolbarItem? {
        switch itemIdentifier {
        case .fetchLicenses:
            return makeToolbarItem(
                button: fetchButton,
                itemIdentifier: .fetchLicenses,
                label: "Fetch",
                toolTip: "Fetch Licenses",
                action: #selector(fetchLicenses)
            )

        case .exportLicenses:
            return makeToolbarItem(
                button: exportButton,
                itemIdentifier: .exportLicenses,
                label: "Export",
                toolTip: "Export Licenses",
                action: #selector(exportLicenses)
            )

        default:
            return nil
        }
    }

    @objc
    private func fetchLicenses() {
        Store.shared.fetchLicenses()
    }

    @objc
    private func exportLicenses() {
        Store.shared.exportLicenses()
    }
}

extension Toolbar {
    func makeToolbarItem(
        button: NSButton,
        itemIdentifier: NSToolbarItem.Identifier,
        label: String,
        toolTip: String,
        action: Selector
    ) -> NSToolbarItem {
        button.isTransparent = true

        let toolbarItem = NSToolbarItem(itemIdentifier: itemIdentifier)
        toolbarItem.label = label
        toolbarItem.paletteLabel = label
        toolbarItem.toolTip = toolTip
        toolbarItem.view = button
        toolbarItem.target = self
        toolbarItem.action = action

        let menuItem: NSMenuItem = .init()
        menuItem.submenu = nil
        menuItem.title = label
        toolbarItem.menuFormRepresentation = menuItem

        return toolbarItem
    }
}

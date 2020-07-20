//
//  RepositoryEntry.swift
//  Licenses
//
//  Created by Andreas Link on 02.07.20.
//

import Cocoa
import SwiftUI

struct ListView: NSViewControllerRepresentable {
    @EnvironmentObject var store: Store

    func makeNSViewController(context: Context) -> ListViewController  {
        let viewController: ListViewController = .init()
        viewController.delegate = context.coordinator
        return viewController
    }

    func updateNSViewController(_ viewController: ListViewController, context: Context) {
        viewController.update(entries: store.listEntries)
    }

    func makeCoordinator() -> ListViewCoordinator {
        return .init(store: store)
    }
}

class ListViewCoordinator {
    private let store: Store

    init(store: Store) {
        self.store = store
    }
}

extension ListViewCoordinator: ListViewControllerDelegate {
    func viewController(_ viewController: ListViewController, didSelectRepositoryWithID id: UUID?) {
        store.selectRepository(with: id)
    }
}

protocol ListViewControllerDelegate {
    func viewController(_ viewController: ListViewController, didSelectRepositoryWithID id: UUID?)
}

final class ListViewController: NSViewController {
    var delegate: ListViewControllerDelegate?

    private var entries: [ListEntry] = []

    private let tableView: NSTableView = .init()
    private let scrollView: NSScrollView = .init()

    override func loadView() {
        self.view = NSView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    private func setupUI() {
        setupTableView()
        setupLayout()
    }

    private func setupScrollView() {
        scrollView.hasVerticalScroller = true
    }

    private func setupTableView() {
        let column: NSTableColumn = .init(identifier: NSUserInterfaceItemIdentifier(rawValue: "entry"))
        tableView.headerView = nil
        tableView.addTableColumn(column)
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func setupLayout() {
        view.addSubview(scrollView)
        scrollView.documentView = tableView
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }

    func update(entries: [ListEntry]) {
        guard self.entries != entries else { return }

        let diff = entries.difference(from: self.entries)

        self.entries = entries

        tableView.beginUpdates()
        for step in diff {
            switch step {
            case let .remove(offset, _, .none):
                tableView.removeRows(at: [offset], withAnimation: .effectFade)

            case let .remove(offset, _, associatedWith?):
                tableView.moveRow(at: offset, to: associatedWith)

            case let .insert(offset, _, _):
                tableView.insertRows(at: [offset], withAnimation: .effectFade)
            }
        }
        tableView.endUpdates()
    }
}

extension ListViewController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return entries.count
    }
}

extension ListViewController: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let view: NSHostingView<RepositoryListEntry> = .init(
            rootView: RepositoryListEntry(
                viewModel: RepositoryListEntryViewModelFactory.makeViewModel(from: entries[row])
            )
        )
        return view
    }

    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        guard let view: NSView = self.tableView(tableView, viewFor: nil, row: row) else { return 44 }

        view.frame.size.width = tableView.frame.size.width
        return view.fittingSize.height
    }

    func tableViewSelectionDidChange(_ notification: Notification) {
        let selectedID: UUID? = tableView.selectedRow >= 0 ? entries[tableView.selectedRow].id : nil
        delegate?.viewController(self, didSelectRepositoryWithID: selectedID)
    }
}

//  Copyright © 2020 Andreas Link. All rights reserved.

import Cocoa
import SwiftUI

struct RepositoryListView: NSViewControllerRepresentable {
    @EnvironmentObject var store: Store

    func makeNSViewController(context: Context) -> ListViewController {
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

protocol ListViewControllerDelegate: AnyObject {
    func viewController(_ viewController: ListViewController, didSelectRepositoryWithID id: UUID?)
}

final class ListViewController: NSViewController {
    weak var delegate: ListViewControllerDelegate?

    private var entries: [RepositoryListEntry] = []

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
        tableView.selectionHighlightStyle = .none
    }

    private func setupLayout() {
        view.addSubview(scrollView)
        scrollView.documentView = tableView
        scrollView.bindEdgesToSuperview()
    }

    func update(entries: [RepositoryListEntry]) {
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
        return nil
    }

    func tableView(_ tableView: NSTableView, rowViewForRow row: Int) -> NSTableRowView? {
        let listEntryView: NSHostingView<RepositoryListEntryView> = .init(
            rootView: RepositoryListEntryView(
                viewModel: RepositoryListEntryViewModelFactory.makeViewModel(from: entries[row])
            )
        )

        listEntryView.frame.size.width = tableView.frame.size.width
        let rowSize: CGSize = .init(width: tableView.frame.size.width, height: listEntryView.fittingSize.height)

        let listEntryRow: RepositoryListEntryRowView = .init(frame: .init(origin: .zero, size: rowSize))
        listEntryRow.addSubview(listEntryView)
        listEntryView.bindEdgesToSuperview()
        return listEntryRow
    }

    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        guard let view: NSView = self.tableView(tableView, rowViewForRow: row) else { return 44 }

        view.frame.size.width = tableView.frame.size.width
        return view.fittingSize.height
    }

    func tableViewSelectionDidChange(_ notification: Notification) {
        let selectedID: UUID? = tableView.selectedRow >= 0 ? entries[tableView.selectedRow].id : nil
        delegate?.viewController(self, didSelectRepositoryWithID: selectedID)
    }
}

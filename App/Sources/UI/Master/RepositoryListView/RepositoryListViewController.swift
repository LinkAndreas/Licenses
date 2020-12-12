//  Copyright © 2020 Andreas Link. All rights reserved.

import AppKit
import Combine
import SwiftUI

final class RepositoryListViewController: NSViewController {
    private enum Constants {
        static let contentInset: NSEdgeInsets = .init(top: 16, left: 0, bottom: 16, right: 0)
    }

    var selection: Binding<UUID?>
    private let store: Store<AppState, AppAction, AppEnvironment>
    private var cancellables: Set<AnyCancellable> = .init()
    private var entries: [RepositoryListEntry] = []
    private let scrollView: NSScrollView = .init(frame: .zero)
    private let tableView: NSTableView = .init(frame: .zero)
    private let column: NSTableColumn = {
        let column: NSTableColumn = .init(identifier: .init(rawValue: "column"))
        column.minWidth = 200
        return column
    }()

    init(store: Store<AppState, AppAction, AppEnvironment>, selection: Binding<UUID?>) {
        self.store = store
        self.selection = selection

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

        setupScrollView()
        setupTableView()
        setupLayout()
        setupBindings()
    }

    private func setupScrollView() {
        scrollView.documentView = tableView
        scrollView.backgroundColor = .clear
        scrollView.drawsBackground = false
        scrollView.contentInsets = Constants.contentInset
        scrollView.hasVerticalScroller = true
        scrollView.hasHorizontalScroller = false
    }

    private func setupTableView() {
        tableView.addTableColumn(column)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.headerView = nil
        tableView.backgroundColor = .clear
        tableView.style = .inset
    }

    private func setupLayout () {
        view.addSubview(scrollView)
        scrollView.bindEdgesToSuperview()
    }

    private func setupBindings() {
        store.$state.sink(receiveValue: self.updateEntries(state:)).store(in: &cancellables)
    }

    private func updateEntries(state: AppState) {
        guard entries != state.listEntries else { return }

        let diff = state.listEntries.difference(from: entries)
        entries = state.listEntries

        tableView.beginUpdates()

        for step in diff {
            switch step {
            case let .remove(offset, _, .none):
                tableView.removeRows(at: [offset])

            case let .remove(offset, _, associatedWith?):
                tableView.moveRow(at: offset, to: associatedWith)

            case let .insert(offset, _, _):
                tableView.insertRows(at: [offset])
            }
        }

        tableView.endUpdates()
    }
}

extension RepositoryListViewController: NSTableViewDelegate {
    func selectionShouldChange(in tableView: NSTableView) -> Bool {
        return true
    }

    func tableViewSelectionDidChange(_ notification: Notification) {
        selection.wrappedValue = tableView.selectedRow != -1 ? entries[tableView.selectedRow].id : nil
    }
}

extension RepositoryListViewController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return entries.count
    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        return nil
    }

    func tableView(_ tableView: NSTableView, rowViewForRow row: Int) -> NSTableRowView? {
        let listEntryView: NSHostingView<RepositoryListEntryView> = .init(
            rootView: RepositoryListEntryView(
                entry: entries[row]
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
}

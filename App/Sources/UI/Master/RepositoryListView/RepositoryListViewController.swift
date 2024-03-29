//  Copyright © 2021 Andreas Link. All rights reserved.

import AppKit
import Combine
import SwiftUI

final class RepositoryListViewController: NSViewController {
    private enum Constants {
        static let contentInset: NSEdgeInsets = .init(top: 16, left: 0, bottom: 16, right: 0)
    }

    private let store: ViewStore<RepositoryListViewState, RepositoryListViewAction>
    private var cancellables: Set<AnyCancellable> = .init()
    private var entries: [RepositoryListEntry] = []
    private let scrollView: NSScrollView = .init(frame: .zero)
    private let tableView: NSTableView = .init(frame: .zero)
    private let column: NSTableColumn = {
        let column: NSTableColumn = .init(identifier: .init(rawValue: "column"))
        column.minWidth = 200
        return column
    }()

    init(store: ViewStore<RepositoryListViewState, RepositoryListViewAction>) {
        self.store = store

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
        tableView.allowsEmptySelection = false
        tableView.backgroundColor = .clear
        tableView.style = .inset
    }

    private func setupLayout () {
        view.addSubview(scrollView)
        scrollView.bindEdgesToSuperview()
    }

    private func setupBindings() {
        store.$state.sink { [weak self] state in
            self?.updateEntries(newEntries: state.entries, selection: state.selection)
        }
        .store(in: &cancellables)
    }

    private func updateEntries(newEntries: [RepositoryListEntry], selection: UUID?) {
        guard entries != newEntries else { return }

        let diff = newEntries.difference(from: entries)
        entries = newEntries

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

        newEntries.firstIndex(where: { $0.id == selection })
            .flatMap(IndexSet.init)
            .flatMap { tableView.selectRowIndexes($0, byExtendingSelection: false) }
    }
}

extension RepositoryListViewController: NSTableViewDelegate {
    func selectionShouldChange(in tableView: NSTableView) -> Bool {
        return true
    }

    func tableViewSelectionDidChange(_ notification: Notification) {
        store.send(.didSelectRepository(tableView.selectedRow != -1 ? entries[tableView.selectedRow].id : nil))
    }
}

extension RepositoryListViewController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return entries.count
    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell: RepositoryListTableCellView = .init(entry: entries[row])
        return cell
    }

    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        guard let view: NSView = self.tableView(tableView, viewFor: column, row: row) else { return 1 }

        view.frame.size.width = tableView.frame.size.width
        return view.fittingSize.height
    }
}

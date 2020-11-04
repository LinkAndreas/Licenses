//  Copyright © 2020 Andreas Link. All rights reserved.

import Cocoa
import Combine
import ComposableArchitecture
import SwiftUI

struct RepositoryListView: NSViewControllerRepresentable {
    let store: Store<AppState, AppAction>

    func updateNSViewController(_ nsViewController: ListViewController, context: Context) {
        return
    }

    func makeNSViewController(context: Context) -> ListViewController {
        let viewController: ListViewController = .init(store: store)
        return viewController
    }
}

protocol ListViewControllerDelegate: AnyObject {
    func viewController(_ viewController: ListViewController, didSelectRepositoryWithID id: UUID?)
}

final class ListViewController: NSViewController {
    weak var delegate: ListViewControllerDelegate?

    private var entries: [RepositoryListEntry] = []

    let viewStore: ViewStore<AppState, AppAction>
    var cancellables: Set<AnyCancellable> = []

    private let tableView: NSTableView = .init()
    private let scrollView: NSScrollView = .init()

    init(store: Store<AppState, AppAction>) {
      self.viewStore = ViewStore(store)

      super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = NSView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupSubscriptions()
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
        tableView.selectionHighlightStyle = .regular

//        Include this for macOS Big Sur
//        if #available(OSX 11.0, *) {
//            tableView.style = .fullWidth
//        }
    }

    private func setupLayout() {
        view.addSubview(scrollView)
        scrollView.documentView = tableView
        scrollView.bindEdgesToSuperview()
    }

    private func setupSubscriptions() {
        viewStore
            .publisher
            .listEntries
            .sink(receiveValue: self.update(entries:))
            .store(in: &self.cancellables)
    }

    private func update(entries: [RepositoryListEntry]) {
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

    func tableViewSelectionDidChange(_ notification: Notification) {
        guard tableView.selectedRow >= 0 else { return }

        self.viewStore.send(.selectedRepository(id: entries[tableView.selectedRow].id))
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
}

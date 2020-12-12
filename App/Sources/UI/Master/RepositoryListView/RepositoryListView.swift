//  Copyright © 2020 Andreas Link. All rights reserved.

import AppKit
import SwiftUI

struct RepositoryListView: NSViewControllerRepresentable {
    let store: Store<AppState, AppAction, AppEnvironment>
    let selection: Binding<UUID?>

    func updateNSViewController(_ nsViewController: RepositoryListViewController, context: Context) {
        return
    }

    func makeNSViewController(context: Context) -> RepositoryListViewController {
        let viewController: RepositoryListViewController = .init(store: store, selection: selection)
        return viewController
    }
}

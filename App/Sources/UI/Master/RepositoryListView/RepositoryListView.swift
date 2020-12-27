//  Copyright © 2021 Andreas Link. All rights reserved.

import AppKit
import SwiftUI

struct RepositoryListView: NSViewControllerRepresentable {
    let store: Store<AppState, AppAction, AppEnvironment>

    func updateNSViewController(_ nsViewController: RepositoryListViewController, context: Context) {
        return
    }

    func makeNSViewController(context: Context) -> RepositoryListViewController {
        return .init(store: store)
    }
}

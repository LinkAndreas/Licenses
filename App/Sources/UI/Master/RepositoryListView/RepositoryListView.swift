//  Copyright © 2021 Andreas Link. All rights reserved.

import SwiftUI

struct RepositoryListView: NSViewControllerRepresentable {
    @ObservedObject var store: ViewStore<RepositoryListViewState, RepositoryListViewAction>

    func updateNSViewController(_ nsViewController: RepositoryListViewController, context: Context) {
        return
    }

    func makeNSViewController(context: Context) -> RepositoryListViewController {
        return .init(store: store)
    }
}

struct RepositoryListView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryListView(store: .constant(state: PreviewData.RepositoryList.state))
    }
}

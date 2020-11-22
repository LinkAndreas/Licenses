//  Copyright © 2020 Andreas Link. All rights reserved.

import SwiftUI

struct RepositoryList: View {
    @EnvironmentObject var store: Store<AppState, AppAction, AppEnvironment>

    var body: some View {
        List(
            store.state.masterViewModel.listEntryViewModels,
            selection: Binding<UUID?>(
                get: { store.state.selectedRepository?.id },
                set: { uuid in store.send(.selectedRepository(id: uuid)) }
            )
        ) { viewModel in
            RepositoryListEntryView(viewModel: viewModel)
                .tag(viewModel.id)
                .animation(nil)
        }
        .animation(.default)
    }
}

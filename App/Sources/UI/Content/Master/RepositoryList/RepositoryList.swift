//  Copyright © 2020 Andreas Link. All rights reserved.

import ComposableArchitecture
import SwiftUI

struct RepositoryList: View {
    let store: Store<AppState, AppAction>

    var body: some View {
        WithViewStore(store) { viewStore in
            List(
                selection: viewStore.binding(
                    get: \.selectedRepository?.id,
                    send: AppAction.selectedRepository(id:)
                )
            ) {
                Section(header: Text(viewStore.masterViewModel.sectionTitle)) {
                    ForEach(viewStore.masterViewModel.listEntryViewModels) { viewModel in
                        RepositoryListEntryView(viewModel: viewModel)
                            .tag(viewModel.id)
                            .animation(nil)
                    }
                }
            }
            .animation(.default)
        }
    }
}

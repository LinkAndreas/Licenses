//  Copyright © 2021 Andreas Link. All rights reserved.

import SwiftUI

struct MasterView: View {
    @ObservedObject var store: ViewStore<MasterViewState, MasterViewAction>

    var body: some View {
        VStack(spacing: 0) {
            RepositoryListView(
                store: store.derived(
                    stateMapper: \.listState,
                    actionMapper: MasterViewAction.repositoryList(action:)
                )
            )

            ViewStoreWithNonOptionalStateProvider(
                from: store.derived(stateMapper: \.informationState).withoutActions,
                success: InformationView.init(store:)
            )
        }
        .listStyle(SidebarListStyle())
        .frame(minWidth: 300, idealWidth: 300, maxWidth: .infinity)
    }
}

struct MasterView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MasterView(
                store: .constant(
                    state: .init(
                        listState: PreviewData.RepositoryList.state,
                        informationState: nil
                    )
                )
            )

            MasterView(
                store: .constant(
                    state: .init(
                        listState: PreviewData.RepositoryList.state,
                        informationState: .init(
                            progressState: PreviewData.Progress.state,
                            errorMessageState: PreviewData.ErrorMessage.state
                        )
                    )
                )
            )

            MasterView(
                store: .constant(
                    state: .init(
                        listState: PreviewData.RepositoryList.state,
                        informationState: .init(
                            progressState: PreviewData.Progress.state,
                            errorMessageState: nil
                        )
                    )
                )
            )

            MasterView(
                store: .constant(
                    state: .init(
                        listState: PreviewData.RepositoryList.state,
                        informationState: .init(
                            progressState: nil,
                            errorMessageState: PreviewData.ErrorMessage.state
                        )
                    )
                )
            )
        }.previewLayout(.sizeThatFits)
    }
}

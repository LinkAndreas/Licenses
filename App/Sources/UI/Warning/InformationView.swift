//  Copyright © 2020 Andreas Link. All rights reserved.

import ComposableArchitecture
import SwiftUI

struct InformationView: View {
    let store: Store<AppState, AppAction>

    var body: some View {
        WithViewStore(store) { viewStore in
            Group {
                if viewStore.progress != nil || viewStore.errorMessage != nil {
                    VStack {
                        ProgressView(store: store)
                        ErrorMessageView(store: store)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                }
            }
        }
    }
}

struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        InformationView(
            store: .init(
                initialState: .init(
                    isProcessing: false,
                    isTargeted: false,
                    progress: 0.75,
                    remainingRepositories: 0,
                    totalRepositories: 0,
                    errorMessage: nil,
                    selectedRepository: nil,
                    repositories: []
                ),
                reducer: appReducer,
                environment: AppEnvironment()
            )
        )
    }
}

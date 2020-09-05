//  Copyright © 2020 Andreas Link. All rights reserved.

import Combine
import ComposableArchitecture
import SwiftUI

struct ProgressView: View {
    let store: Store<AppState, AppAction>

    var body: some View {
        WithViewStore(store) { viewStore in
            viewStore.progress.map {
                ProgressBar(value: .constant($0))
                    .frame(height: 5)
            }
        }
    }
}

struct Progress_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView(
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
        .previewLayout(.fixed(width: 650, height: 500))
    }
}

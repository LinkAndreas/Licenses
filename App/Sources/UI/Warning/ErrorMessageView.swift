//  Copyright © 2020 Andreas Link. All rights reserved.

import Combine
import ComposableArchitecture
import SwiftUI

struct ErrorMessageView: View {
    let store: Store<AppState, AppAction>

    var body: some View {
        WithViewStore(store) { viewStore in
            Group {
                viewStore.errorMessage.map { errorMessage in
                    Group {
                        Text(errorMessage)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.red)
                    }
                }
            }
        }
    }
}

struct GithubRequestLimitView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorMessageView(
            store: .init(
                initialState: .init(
                    isProcessing: false,
                    isTargeted: false,
                    progress: nil,
                    remainingRepositories: 0,
                    totalRepositories: 0,
                    errorMessage: "Test Error Message",
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

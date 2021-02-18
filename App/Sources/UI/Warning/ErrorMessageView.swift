//  Copyright © 2021 Andreas Link. All rights reserved.

import Combine
import SwiftUI

struct ErrorMessageView: View {
    @EnvironmentObject var store: Store<AppState, AppAction, AppEnvironment>

    var body: some View {
        Group {
            store.state.errorMessage.map { errorMessage in
                Group {
                    Text(errorMessage)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.red)
                }
            }
        }
    }
}

struct GithubRequestLimitView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorMessageView()
            .environmentObject(
                Store<AppState, AppAction, AppEnvironment>(
                    initialState: .init(
                        isProcessing: false,
                        isTargeted: false,
                        progress: nil,
                        remainingRepositories: 0,
                        totalRepositories: 0,
                        errorMessage: "Test Error Message",
                        selection: nil,
                        repositories: []
                    ),
                    reducer: appReducer,
                    environment: DefaultEnvironment()
                )
            )
            .previewLayout(.fixed(width: 650, height: 500))
    }
}

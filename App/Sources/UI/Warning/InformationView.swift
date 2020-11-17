//  Copyright © 2020 Andreas Link. All rights reserved.

import SwiftUI

struct InformationView: View {
    @EnvironmentObject var store: Store<AppState, AppAction, AppEnvironment>

    var body: some View {
        if store.state.progress != nil || store.state.errorMessage != nil {
            VStack {
                ProgressView()
                ErrorMessageView()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
        }
    }
}

struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        InformationView()
            .environmentObject(
                Store<AppState, AppAction, AppEnvironment>(
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

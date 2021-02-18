//  Copyright © 2021 Andreas Link. All rights reserved.

import Combine
import SwiftUI

struct ProgressView: View {
    @EnvironmentObject var store: Store<AppState, AppAction, AppEnvironment>

    var body: some View {
        store.state.progress.map {
            ProgressBar(value: .constant($0))
                .frame(height: 5)
        }
    }
}

struct Progress_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView()
            .environmentObject(
                Store<AppState, AppAction, AppEnvironment>(
                    initialState: .init(
                        isProcessing: false,
                        isTargeted: false,
                        progress: 0.75,
                        remainingRepositories: 0,
                        totalRepositories: 0,
                        errorMessage: nil,
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

//  Copyright © 2020 Andreas Link. All rights reserved.

import ComposableArchitecture

let store: Store<AppState, AppAction> = .init(
    initialState: .init(
        isProcessing: false,
        isTargeted: false,
        progress: nil,
        errorMessage: nil,
        selectedRepository: nil,
        repositories: []
    ),
    reducer: appReducer,
    environment: AppEnvironment()
)

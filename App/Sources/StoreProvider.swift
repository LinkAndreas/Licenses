//  Copyright © 2020 Andreas Link. All rights reserved.

import Foundation

final class StoreProvider {
    static let shared: StoreProvider = .init()

    let store = Store(
      initialState: AppState(),
      reducer: ReducerFactory.appReducer,
      environment: AppEnvironment()
    )

    private init() { /* Singleton */ }
}

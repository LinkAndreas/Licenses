//  Copyright © 2020 Andreas Link. All rights reserved.

import ComposableArchitecture
import Foundation

final class StoreProvider: ObservableObject {
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

    init() {
        addObservers()
    }

    deinit {
        removeObservers()
    }

    private func addObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleErrorMessageChanged),
            name: .errorMessageChanged,
            object: nil
        )
    }

    private func removeObservers() {
        NotificationCenter.default.removeObserver(self)
    }

    @objc
    private func handleErrorMessageChanged(_ notification: Notification) {
        guard let errorMessage: String = notification.userInfo?[String.errorMessageKey] as? String else { return }

        ViewStore(store).send(.updateErrorMessage(value: errorMessage))
    }
}

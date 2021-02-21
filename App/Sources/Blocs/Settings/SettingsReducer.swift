//  Copyright © 2021 Andreas Link. All rights reserved.

import Combine
import Foundation

struct SettingsReducer: BlocReducer {
    func reduce(
        state: inout SettingsState,
        action: SettingsAction,
        environment: SettingsEnvironment
    ) -> Effect<SettingsAction, Never> {
        switch action {
        case .readIsAutomaticFetchEnabled:
            state.isAutomaticFetchEnabled = environment.settingsDataSource.isAutomaticFetchEnabled
            return .none

        case .readToken:
            state.token = environment.settingsDataSource.token
            return .none

        case let .didChangeIsAutomaticFetchEnabled(value):
            environment.settingsDataSource.isAutomaticFetchEnabled = value
            return Effect(value: .readIsAutomaticFetchEnabled)

        case let .didChangeToken(value):
            environment.settingsDataSource.token = value
            return Effect(value: .readToken)
        }
    }
}

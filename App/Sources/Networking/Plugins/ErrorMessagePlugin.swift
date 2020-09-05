//  Copyright © 2020 Andreas Link. All rights reserved.

import Aphrodite
import ComposableArchitecture
import Foundation

final class ErrorMessagePlugin: NetworkPlugin {
    func didReceive(_ result: Result<NetworkResponse, AphroditeError>, target: NetworkTarget) {
        switch result {
        case .success:
            ViewStore(store).send(.updateErrorMessage(value: nil))

        case let .failure(error):
            switch DomainErrorFactory.make(from: error) {
            case .githubRateLimitExceeded:
                ViewStore(store).send(.updateErrorMessage(value: L10n.Error.githubRateLimitExceeded))

            case .unauthorized:
                ViewStore(store).send(.updateErrorMessage(value: L10n.Error.unauthorized))

            default:
                return
            }
        }
    }
}

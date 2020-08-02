//  Copyright © 2020 Andreas Link. All rights reserved.

import Aphrodite
import Foundation

final class ErrorMessagePlugin: NetworkPlugin {
    func didReceive(_ result: Result<NetworkResponse, AphroditeError>, target: NetworkTarget) {
        switch result {
        case .success:
            Store.shared.errorMessage = nil

        case let .failure(error):
            switch DomainErrorFactory.make(from: error) {
            case .githubRateLimitExceeded:
                Store.shared.errorMessage = L10n.Error.githubRateLimitExceeded

            case .unauthorized:
                Store.shared.errorMessage = L10n.Error.unauthorized

            default:
                return
            }
        }
    }
}

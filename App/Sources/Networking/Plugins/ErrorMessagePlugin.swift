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
                Store.shared.errorMessage = "Github Request limit exceeded. Please try again later or add a personal access token in preferences to increase your rate limit."

            case .unauthorized:
                Store.shared.errorMessage = "Unauthorized, please verify your personal access token in preferences."

            default:
                return
            }
        }
    }
}

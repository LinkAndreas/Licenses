//  Copyright © 2020 Andreas Link. All rights reserved.

import Aphrodite
import Foundation

final class RemainingGithubRequestsPlugin: NetworkPlugin {
    func didReceive(_ result: Result<NetworkResponse, AphroditeError>, target: NetworkTarget) {
        switch result {
        case let .success(response):
            guard let status = GithubRequestStatusFactory.make(from: response.headerFields) else { return }

            Store.shared.githubRequestStatus = status

        case let .failure(error):
            if case let .githubRateLimitExceeded(status) = DomainErrorFactory.make(from: error) {
                Store.shared.githubRequestStatus = status
            }
        }
    }
}
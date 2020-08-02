//  Copyright © 2020 Andreas Link. All rights reserved.

import Aphrodite
import Foundation

enum DomainError: Error {
    case forbidden(HTTPURLResponse, Data)
    case serviceCancelled
    case notConnectedToInternet
    case githubRateLimitExceeded
    case unauthorized
    case unexpected
}

enum DomainErrorFactory: AphroditeDomainErrorFactory {
    static func make(from error: AphroditeError) -> DomainError {
        switch error {
        case let .forbidden(response, data):
            guard
                let status: GithubRequestStatus = GithubRequestStatusFactory.make(from: response.allHeaderFields),
                status.remaining == 0
            else {
                return .forbidden(response, data)
            }

            return .githubRateLimitExceeded

        case .serviceCancelled:
            return .serviceCancelled

        case .notConnectedToInternet:
            return .notConnectedToInternet

        case .unauthorized:
            return .unauthorized

        default:
            return .unexpected
        }
    }
}

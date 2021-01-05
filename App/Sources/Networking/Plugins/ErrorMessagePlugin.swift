//  Copyright © 2021 Andreas Link. All rights reserved.

import Aphrodite
import Foundation

extension Notification.Name {
    static let errorMessageChanged: Self = .init(.errorMessageChangedIdentifier)
}

extension String {
    static let errorMessageKey: Self = "errorMessageKey"
    static let errorMessageChangedIdentifier: Self = "errorMessageChangedIdentifier"
}

final class ErrorMessagePlugin: NetworkPlugin {
    var targetScope: NetworkPluginTargetScope { .github }

    func didReceive(_ result: Result<NetworkResponse, AphroditeError>, target: NetworkTarget) {
        let errorMessage: String?
        switch result {
        case .success:
            errorMessage = nil

        case let .failure(error):
            switch DomainErrorFactory.make(from: error) {
            case .githubRateLimitExceeded:
                errorMessage = L10n.Error.githubRateLimitExceeded

            case .unauthorized:
                errorMessage = L10n.Error.unauthorized

            default:
                errorMessage = nil
            }
        }

        NotificationCenter.default.post(
            name: .errorMessageChanged,
            object: self,
            userInfo: [String.errorMessageKey: errorMessage as Any]
        )
    }
}

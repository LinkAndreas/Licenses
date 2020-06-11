//  Copyright © 2020 Andreas Link. All rights reserved.

import Aphrodite
import Foundation

enum DomainError: Error {
    case forbidden(HTTPURLResponse, Data)
    case serviceCancelled
    case notConnectedToInternet
    case unexpected
}

enum DomainErrorFactory: AphroditeDomainErrorFactory {
    static func make(from error: AphroditeError) -> DomainError {
        switch error {
        case let .forbidden(response, data):
            return .forbidden(response, data)

        case .serviceCancelled:
            return .serviceCancelled

        case .notConnectedToInternet:
            return .notConnectedToInternet

        default:
            return .unexpected
        }
    }
}

//  Copyright © 2020 Andreas Link. All rights reserved.

import Aphrodite
import Foundation

enum DomainError: Error {
    case encoding(EncodingError)
    case decoding(DecodingError)
    case client(HTTPURLResponse, Int)
    case server(HTTPURLResponse, Int)
    case unauthorized(HTTPURLResponse)
    case underlying(HTTPURLResponse, Error)
    case forbidden(HTTPURLResponse)
    case notFound(HTTPURLResponse)
    case notConnectedToInternet
    case serviceCancelled
    case unexpected
}

enum DomainErrorFactory: AphroditeDomainErrorFactory {
    static func make(from error: AphroditeError) -> DomainError { // swiftlint:disable:this cyclomatic_complexity
        switch error {
        case let .underlying(response, error):
            return .underlying(response, error)

        case let .unauthorized(response):
            return .unauthorized(response)

        case let .forbidden(response):
            return .forbidden(response)

        case let .notFound(response):
            return .notFound(response)

        case let .encoding(error):
            return .encoding(error)

        case let .decoding(error):
            return .decoding(error)

        case let .client(response, statusCode):
            return .client(response, statusCode)

        case let .server(response, statusCode):
            return .server(response, statusCode)

        case .notConnectedToInternet:
            return .notConnectedToInternet

        case .serviceCancelled:
            return .serviceCancelled

        default:
            return .unexpected
        }
    }
}

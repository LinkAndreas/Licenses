//  Copyright © 2020 Andreas Link. All rights reserved.

import Aphrodite
import Combine
import Foundation

final class AuthPlugin: NetworkPlugin {
    func prepare(_ request: URLRequest, target: NetworkTarget) -> AnyPublisher<URLRequest, Never> {
        guard target is Github else { return Just<URLRequest>(request).eraseToAnyPublisher() }

        var modifiedRequest: URLRequest = request
        modifiedRequest.addValue(
            "token 558a5f4bdc0ee22b6419b8860651475d34df6597",
            forHTTPHeaderField: HttpHeaderField.authorization.rawValue
        )
        return Just<URLRequest>(modifiedRequest).eraseToAnyPublisher()
    }
}

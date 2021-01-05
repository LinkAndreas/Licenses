//  Copyright © 2021 Andreas Link. All rights reserved.

import Aphrodite
import Combine
import Foundation
import SwiftUI

final class AuthPlugin: NetworkPlugin {
    var targetScope: NetworkPluginTargetScope { .github }

    func prepare(_ request: URLRequest, target: NetworkTarget) -> AnyPublisher<URLRequest, Never> {
        guard target is Github else { return Just<URLRequest>(request).eraseToAnyPublisher() }

        var modifiedRequest: URLRequest = request

        if !Defaults.token.isEmpty {
            modifiedRequest.addValue(
                "token \(Defaults.token)",
                forHTTPHeaderField: HttpHeaderField.authorization.rawValue
            )
        }

        return Just<URLRequest>(modifiedRequest).eraseToAnyPublisher()
    }
}

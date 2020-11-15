//  Copyright © 2020 Andreas Link. All rights reserved.

import Aphrodite
import Combine
import Foundation
import SwiftUI

final class AuthPlugin: NetworkPlugin {
    @AppStorage("token") private var token: String = ""

    var targetScope: NetworkPluginTargetScope { .github }

    func prepare(_ request: URLRequest, target: NetworkTarget) -> AnyPublisher<URLRequest, Never> {
        guard target is Github else { return Just<URLRequest>(request).eraseToAnyPublisher() }

        var modifiedRequest: URLRequest = request

        if !token.isEmpty {
            modifiedRequest.addValue(
                "token \(token)",
                forHTTPHeaderField: HttpHeaderField.authorization.rawValue
            )
        }

        return Just<URLRequest>(modifiedRequest).eraseToAnyPublisher()
    }
}

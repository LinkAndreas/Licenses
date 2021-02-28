//  Copyright © 2021 Andreas Link. All rights reserved.

import Aphrodite
import Combine
import Foundation
import SwiftUI

final class AuthPlugin: NetworkPlugin {
    private let settingsDataSource: SettingsSynchronousDataSource

    var targetScope: NetworkPluginTargetScope { .github }

    init(settingsDataSource: SettingsSynchronousDataSource = Defaults.shared) {
        self.settingsDataSource = settingsDataSource
    }

    func prepare(_ request: URLRequest, target: NetworkTarget) -> AnyPublisher<URLRequest, Never> {
        guard target is Github else { return Just<URLRequest>(request).eraseToAnyPublisher() }

        var modifiedRequest: URLRequest = request

        if !settingsDataSource.token.isEmpty {
            modifiedRequest.addValue(
                "token \(settingsDataSource.token)",
                forHTTPHeaderField: HttpHeaderField.authorization.rawValue
            )
        }

        return Just<URLRequest>(modifiedRequest).eraseToAnyPublisher()
    }
}

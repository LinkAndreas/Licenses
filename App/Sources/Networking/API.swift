//  Copyright © 2020 Andreas Link. All rights reserved.

import Aphrodite
import Foundation

extension NetworkPluginTargetScope {
    static let github: Self = .init(identifier: "github")
}

let API: AphroditeClient<DomainErrorFactory> = .init(
    plugins: [
        // NetworkLoggerPlugin(),
        AuthPlugin(),
        ErrorMessagePlugin()
    ]
)

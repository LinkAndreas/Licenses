//  Copyright © 2020 Andreas Link. All rights reserved.

import Aphrodite
import Foundation

extension NetworkPluginType {
    static let github: NetworkPluginType = .init(identifier: "github")
}

let API: Aphrodite<DomainErrorFactory> = .init(
    plugins: [
        .universal: [
            // NetworkLoggerPlugin()
        ],
        .github: [
            AuthPlugin(),
            ErrorMessagePlugin()
        ]
    ]
)

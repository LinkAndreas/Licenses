//  Copyright © 2021 Andreas Link. All rights reserved.

import Foundation

struct SupportedManifestsViewState: Equatable {
    let title: String
    let entries: [SupportedManifestEntry]
}

struct SupportedManifestEntry: Identifiable, Equatable {
    let id: UUID
    let description: String
    let imageSystemName: String

    init(
        id: UUID = .init(),
        description: String = "",
        imageSystemName: String = ""
    ) {
        self.id = id
        self.description = description
        self.imageSystemName = imageSystemName
    }
}

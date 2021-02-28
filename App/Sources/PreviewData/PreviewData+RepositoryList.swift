//  Copyright © 2021 Andreas Link. All rights reserved.

import Foundation

extension PreviewData {
    enum RepositoryList {
        static let state: RepositoryListViewState = {
            let selection: UUID = .init()

            return .init(
                entries: [
                    .init(
                        title: "Title 1",
                        subtitle: "Subtitle 1",
                        caption: "Caption 1",
                        showsProgressIndicator: false
                    ),
                    .init(
                        id: selection,
                        title: "Title 2",
                        subtitle: "Subtitle 2",
                        caption: "Caption 2",
                        showsProgressIndicator: true
                    ),
                    .init(
                        title: "Title 3",
                        subtitle: "Subtitle 3",
                        showsProgressIndicator: false
                    ),
                    .init(
                        title: "Title 4",
                        caption: "Caption 4",
                        showsProgressIndicator: false
                    )
                ],
                selection: selection
            )
        }()
    }
}

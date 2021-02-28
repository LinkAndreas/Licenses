//  Copyright © 2021 Andreas Link. All rights reserved.

extension PreviewData {
    enum DetailPlaceholder {
        static let state: DetailPlaceholderViewState = .init(
            title: "Title",
            subtitle: "Subtitle",
            entries: [
                .init(
                    title: "XXXXX",
                    subtitle: "XXXXXXXX",
                    caption: "XX"
                ),
                .init(
                    title: "XX",
                    subtitle: "XXXXX",
                    caption: "XXXXXX",
                    offset: -60
                ),
                .init(
                    title: "XXXXXXXX",
                    subtitle: "XXXXXXXXXXXXXX",
                    caption: "XXXX",
                    offset: 40
                ),
                .init(
                    title: "XXXXXXXXXX",
                    subtitle: "XXX",
                    caption: "XXXXXXXXXXXXXXXXXX",
                    offset: 15
                )
            ],
            primaryButtonTitle: "Primary Button Title",
            secondaryButtonTitle: "Secondary Button Title",
            isPrimaryButtonDisabled: true,
            isSecondaryButtonDisabled: false
        )
    }
}

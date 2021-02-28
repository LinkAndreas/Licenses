//  Copyright © 2021 Andreas Link. All rights reserved.

enum DetailPlaceholderViewStateMapper {
    static func map(state: AppState) -> DetailPlaceholderViewState? {
        guard state.selectedRepository == nil, !state.isProcessing else { return nil }

        return .init(
            title: L10n.Detail.Placeholder.title,
            subtitle: L10n.Detail.Placeholder.subtitle,
            entries: [
                .init(
                    title: "xxxxxxxxxxxxxx",
                    subtitle: "xxxxxxxxxx",
                    caption: "xxxxxxxxxxxxxxx",
                    offset: 40
                ),
                .init(
                    title: "xxxxxxxxxxxxxxx",
                    subtitle: "xxxxxx",
                    caption: "xxxxxxxxx",
                    offset: -30
                ),
                .init(
                    title: "xxxx",
                    subtitle: "xxxxxxxxxxxx",
                    caption: "xxxxxxxxxxxxxxxxxxx",
                    offset: 90
                )
            ],
            primaryButtonTitle: L10n.Detail.Placeholder.Button.ChooseManifests.title,
            secondaryButtonTitle: L10n.Detail.Placeholder.Button.ExampleManifest.title,
            isPrimaryButtonDisabled: state.isProcessing,
            isSecondaryButtonDisabled: state.isProcessing
        )
    }
}

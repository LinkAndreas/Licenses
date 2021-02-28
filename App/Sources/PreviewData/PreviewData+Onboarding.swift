//  Copyright © 2021 Andreas Link. All rights reserved.

extension PreviewData {
    enum Onboarding {
        static let state: OnboardingViewState = .init(
            title: "Title",
            subtitle: "Subtitle",
            primaryButtonTitle: "Primary Button Title",
            supportedManifestsState: supportedManifests
        )

        static let supportedManifests: SupportedManifestsViewState = .init(
            title: "Title",
            entries: [
                .init(description: "Description 1", imageSystemName: "swift"),
                .init(description: "Description 2", imageSystemName: "swift"),
                .init(description: "Description 3", imageSystemName: "swift"),
                .init(description: "Description 4", imageSystemName: "swift")
            ]
        )
    }
}

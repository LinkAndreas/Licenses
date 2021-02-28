//  Copyright © 2021 Andreas Link. All rights reserved.

enum OnboardingViewStateMapper {
    static func map(state: AppState) -> OnboardingViewState {
        .init(
            title: L10n.Onboarding.title,
            subtitle: L10n.Onboarding.subtitle,
            primaryButtonTitle: L10n.Onboarding.PrimaryButton.title,
            supportedManifestsState: SupportedManifestsViewStateMapper.map(state: state)
        )
    }
}

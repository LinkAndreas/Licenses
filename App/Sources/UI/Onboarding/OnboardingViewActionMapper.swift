//  Copyright © 2021 Andreas Link. All rights reserved.

enum OnboardingViewActionMapper {
    static func map(action: OnboardingViewAction) -> AppAction {
        switch action {
        case .didTriggerPrimaryButton:
            return .updateIsOnboardingCompleted(true)
        }
    }
}

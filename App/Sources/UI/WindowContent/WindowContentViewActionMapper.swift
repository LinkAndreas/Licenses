//  Copyright © 2021 Andreas Link. All rights reserved.

enum WindowContentViewActionMapper {
    static func map(action: WindowContentViewAction) -> AppAction {
        switch action {
        case .didAppear:
            return .registerErrorMessageSubscription

        case .didDisappear:
            return .unregisterFromErrorMessageSubscription

        case let .updateIsOnboardingCompleted(isOnboardingCompleted):
            return .updateIsOnboardingCompleted(isOnboardingCompleted)

        case let .onboarding(action):
            return OnboardingViewActionMapper.map(action: action)

        case let .fileDropArea(action):
            return FileDropAreaActionMapper.map(action: action)

        case let .master(action):
            return MasterViewActionMapper.map(action: action)

        case let .detail(action):
            return DetailViewActionMapper.map(action: action)

        case let .toolbar(action):
            return ToolbarItemsActionMapper.map(action: action)
        }
    }
}

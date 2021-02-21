//  Copyright © 2021 Andreas Link. All rights reserved.

enum WindowContentViewAction {
    case didAppear
    case didDisappear
    case updateIsOnboardingCompleted(Bool)
    case onboarding(action: OnboardingViewAction)
    case fileDropArea(action: FileDropAreaViewAction)
    case toolbar(action: ToolbarItemsAction)
    case master(action: MasterViewAction)
    case detail(action: DetailViewAction)
}

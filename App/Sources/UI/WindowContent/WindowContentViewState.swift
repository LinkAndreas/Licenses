//  Copyright © 2021 Andreas Link. All rights reserved.

struct WindowContentViewState: Equatable {
    let isOnboardingPresented: Bool
    let onboardingState: OnboardingViewState
    let toolbarState: ToolbarItemsState
    let fileDropAreaState: FileDropAreaViewState
    let masterState: MasterViewState
    let detailState: DetailViewState
}

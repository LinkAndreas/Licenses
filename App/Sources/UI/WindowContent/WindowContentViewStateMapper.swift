//  Copyright © 2021 Andreas Link. All rights reserved.

enum WindowContentViewStateMapper {
    static func map(state: AppState) -> WindowContentViewState {
        return .init(
            isOnboardingPresented: !state.isOnboardingCompleted,
            onboardingState: OnboardingViewStateMapper.map(state: state),
            toolbarState: ToolbarItemsStateMapper.map(state: state),
            fileDropAreaState: FileDropAreaViewStateMapper.map(state: state),
            masterState: MasterViewStateMapper.map(state: state),
            detailState: DetailViewStateMapper.map(state: state)
        )
    }
}

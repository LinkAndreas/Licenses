//  Copyright © 2021 Andreas Link. All rights reserved.

enum InformationViewStateMapper {
    static func map(state: AppState) -> InformationViewState? {
        guard state.progress != nil || state.errorMessage != nil else { return nil }

        return .init(
            progressState: ProgressViewStateMapper.map(state: state),
            errorMessageState: ErrorMessageViewStateMapper.map(state: state)
        )
    }
}

//  Copyright © 2021 Andreas Link. All rights reserved.

enum ProgressViewStateMapper {
    static func map(state: AppState) -> ProgressViewState {
        return .init(progress: state.progress)
    }
}

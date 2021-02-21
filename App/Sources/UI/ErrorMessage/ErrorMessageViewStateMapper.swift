//  Copyright © 2021 Andreas Link. All rights reserved.

enum ErrorMessageViewStateMapper {
    static func map(state: AppState) -> ErrorMessageViewState? {
        guard let message = state.errorMessage else { return nil }

        return .init(message: message)
    }
}

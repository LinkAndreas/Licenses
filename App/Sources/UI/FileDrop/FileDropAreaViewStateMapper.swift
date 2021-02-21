//  Copyright © 2021 Andreas Link. All rights reserved.

enum FileDropAreaViewStateMapper {
    static func map(state: AppState) -> FileDropAreaViewState {
        return .init(
            isTargeted: state.isTargeted,
            supportedFileTypes: ["public.file-url"]
        )
    }
}

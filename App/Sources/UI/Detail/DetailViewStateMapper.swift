//  Copyright © 2021 Andreas Link. All rights reserved.

enum DetailViewStateMapper {
    static func map(state: AppState) -> DetailViewState {
        return .init(
            navigationTitle: state.selectedRepository?.name ?? "",
            listState: DetailListViewStateMapper.map(state: state),
            placeholderState: DetailPlaceholderViewStateMapper.map(state: state)
        )
    }
}

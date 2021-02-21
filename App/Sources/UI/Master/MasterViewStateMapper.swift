//  Copyright © 2021 Andreas Link. All rights reserved.

enum MasterViewStateMapper {
    static func map(state: AppState) -> MasterViewState {
        return .init(
            listState: RepositoryListViewStateMapper.map(state: state),
            informationState: InformationViewStateMapper.map(state: state)
        )
    }
}

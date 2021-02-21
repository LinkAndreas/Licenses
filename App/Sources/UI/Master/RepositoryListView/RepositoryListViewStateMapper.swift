//  Copyright © 2021 Andreas Link. All rights reserved.

enum RepositoryListViewStateMapper {
    static func map(state: AppState) -> RepositoryListViewState {
        return .init(
            entries: state.repositories.map { repository in
                return .init(
                    id: repository.id,
                    title: repository.name,
                    subtitle: repository.version,
                    caption: repository.packageManager.rawValue,
                    showsProgressIndicator: repository.isProcessing
                )
            },
            selection: state.selectedRepository?.id
        )
    }
}

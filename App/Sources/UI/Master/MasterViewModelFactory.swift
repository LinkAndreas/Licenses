//  Copyright © 2020 Andreas Link. All rights reserved.

import SwiftUI

enum MasterViewModelFactory {
    static func makeViewModel(from state: AppState) -> MasterViewModel {
        return .init(
            sectionTitle: "Repositories",
            listEntryViewModels: makeListEntryViewModels(from: state)
        )
    }
}

extension MasterViewModelFactory {
    private static func makeListEntryViewModels(from state: AppState) -> [RepositoryListEntryViewModel] {
        return state.repositories.map { repository in
            let isSelected: Bool = state.selectedRepository?.id == repository.id

            return .init(
                id: repository.id,
                title: repository.name,
                subtitle: repository.version,
                caption: repository.packageManager.rawValue,
                showsProgressIndicator: repository.isProcessing,
                titleColor: isSelected ? .alternateSelectedControlTextColor : .labelColor,
                subtitleColor: isSelected ? .alternateSelectedControlTextColor : .secondaryLabelColor,
                captionColor: isSelected ? .alternateSelectedControlTextColor : .secondaryLabelColor
            )
        }
    }
}

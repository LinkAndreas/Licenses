//  Copyright © 2021 Andreas Link. All rights reserved.

struct DetailViewState: Equatable {
    let navigationTitle: String
    let listState: DetailListViewState?
    let placeholderState: DetailPlaceholderViewState?

    init(
        navigationTitle: String = "",
        listState: DetailListViewState? = nil,
        placeholderState: DetailPlaceholderViewState? = nil
    ) {
        self.navigationTitle = navigationTitle
        self.listState = listState
        self.placeholderState = placeholderState
    }
}

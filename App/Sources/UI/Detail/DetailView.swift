//  Copyright © 2021 Andreas Link. All rights reserved.

import Cocoa
import Combine
import SwiftUI

struct DetailView: View {
    @ObservedObject var store: ViewStore<DetailViewState, DetailViewAction>

    var body: some View {
        Group {
            ViewStoreWithNonOptionalStateProvider(
                from: store.derived(stateMapper: \.listState).withoutActions,
                success: DetailListView.init(store:),
                failure: ViewStoreWithNonOptionalStateProvider(
                    from: store.derived(
                        stateMapper: \.placeholderState,
                        actionMapper: DetailViewAction.placeholder(action:)
                    ),
                    success: DetailPlaceholderView.init(store:)
                )
            )
        }
        .navigationTitle(store.navigationTitle)
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DetailView(
                store: .constant(
                    state: .init(
                        navigationTitle: "Navigation Title",
                        placeholderState: PreviewData.DetailPlaceholder.state
                    )
                )
            )

            DetailView(
                store: .constant(
                    state: .init(
                        navigationTitle: "Navigation Title",
                        listState: PreviewData.DetailList.state
                    )
                )
            )
        }.previewLayout(.fixed(width: 450, height: 780))
    }
}

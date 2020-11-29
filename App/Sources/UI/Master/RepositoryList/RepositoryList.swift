//  Copyright © 2020 Andreas Link. All rights reserved.

import SwiftUI

struct RepositoryList: View {
    @EnvironmentObject var store: Store<AppState, AppAction, AppEnvironment>

    var body: some View {
        List(
            store.state.listEntries,
            selection: Binding<UUID?>(
                get: { store.state.selectedRepository?.id },
                set: { uuid in
                    guard uuid != store.state.selectedRepository?.id else { return }

                    store.send(.selectedRepository(id: uuid))
                }
            )
        ) { entry in
            RepositoryListEntryView(entry: entry)
                .tag(entry.id)
                .animation(nil)
        }
        .animation(.default)
    }
}

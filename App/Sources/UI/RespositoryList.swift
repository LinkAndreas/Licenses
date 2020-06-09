//  Copyright © 2020 Andreas Link. All rights reserved.

import ComposableArchitecture
import SwiftUI

struct RepositoryList: View {
    let store: Store<AppState, AppAction>

    var body: some View {
        WithViewStore(self.store) { viewStore in
            List(
                selection: viewStore.binding(
                    get: { $0.selectedRepository },
                    send: { .selectRepository($0) }
                )
            ) {
                ForEach(viewStore.repositories) { repository in
                    HStack {
                        Text(repository.name)
                            .font(.headline)
                        Text(repository.version)
                            .font(.subheadline)
                    }
                    .padding()
                    .tag(repository)
                }
            }
        }
    }
}

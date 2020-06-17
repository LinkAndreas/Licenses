//  Copyright © 2020 Andreas Link. All rights reserved.

import SwiftUI

struct RepositoryList: View {
    @EnvironmentObject var store: Store<AppState, AppAction, AppEnvironment>

    var body: some View {
        ViewStoreProvider(self.store) { viewStore in
            VStack {
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
                GithubRequestLimitView()
            }
        }
    }
}

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
                        .animation(nil)
                    }
                }
                .animation(.linear)
                if viewStore.progress != nil {
                    ProgressBar(value: .constant(viewStore.progress!))
                        .frame(height: 5)
                        .padding([.leading, .trailing, .bottom], 8)
                }
                GithubRequestLimitView()
            }
        }
    }
}

struct RespositoryList_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryList()
            .environmentObject(
                Store(
                    initialState: AppState(
                        isTargeted: false,
                        repositories: [
                            GithubRepository(
                                packageManager: .carthage,
                                name: "Eureka",
                                version: "5.2.1",
                                author: "xmartlabs",
                                url: URL(string: "https://github.com/xmartlabs/Eureka")
                            )
                        ],
                        githubRequestStatus: nil,
                        progress: 0.5
                    ),
                    reducer: ReducerFactory.appReducer,
                    environment: AppEnvironment()
                )
        )
        .previewLayout(.fixed(width: 350, height: 500))
    }
}

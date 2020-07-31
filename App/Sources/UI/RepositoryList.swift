//  Copyright © 2020 Andreas Link. All rights reserved.

import Combine
import SwiftUI

struct RepositoryList: View {
    @EnvironmentObject var store: Store

    var body: some View {
        VStack {
            List(selection: $store.selectedRepository) {
                ForEach(store.repositories) { repository in
                    HStack {
                        Text(repository.name)
                            .font(.headline)
                        Text(repository.version)
                            .font(.subheadline)
                        Spacer()
                    }
                    .tag(repository)
                    .padding()
                    .animation(nil)
                }
            }
            .animation(.linear)
            store.progress.map {
                ProgressBar(value: .constant($0))
                    .frame(height: 5)
                    .padding([.leading, .trailing, .bottom], 8)
            }
            GithubRequestLimitView()
        }
    }
}

struct RespositoryList_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryList()
            .environmentObject(
                Store(
                    isTargeted: false,
                    progress: 0.5,
                    repositories: [
                        GithubRepository(
                            packageManager: .carthage,
                            name: "Eureka",
                            version: "5.2.1",
                            author: "xmartlabs",
                            url: URL(string: "https://github.com/xmartlabs/Eureka")
                        )
                    ]
                )
        )
        .previewLayout(.fixed(width: 350, height: 500))
    }
}
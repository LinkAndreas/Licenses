//  Copyright © 2020 Andreas Link. All rights reserved.

import SwiftUI

struct RepositoryList: View {
    @EnvironmentObject var store: WindowStore

    var body: some View {
        VStack {
            List(selection: $store.selectedRepository) {
                ForEach(store.repositories) { repository in
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
            if store.progress != nil {
                ProgressBar(value: .constant(store.progress!))
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
                WindowStore(
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
                    selectedRepository: nil,
                    progress: 0.5
                )
        )
        .previewLayout(.fixed(width: 350, height: 500))
    }
}

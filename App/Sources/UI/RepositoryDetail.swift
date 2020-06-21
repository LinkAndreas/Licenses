//  Copyright © 2020 Andreas Link. All rights reserved.

import SwiftUI

struct RepositoryDetail: View {
    @EnvironmentObject var store: Store<AppState, AppAction, AppEnvironment>

    var body: some View {
        GeometryReader { geometry in
            ViewStoreProvider(self.store) { viewStore in
                VStack {
                    if viewStore.selectedRepository != nil {
                        HStack {
                            VStack(alignment: .leading) {
                                viewStore.selectedRepository.map { Text($0.name) }
                                viewStore.selectedRepository.map { Text($0.version) }
                                viewStore.selectedRepository.map { Text($0.packageManager.rawValue) }
                                viewStore.selectedRepository?.author.map { Text($0) }
                                viewStore.selectedRepository?.url.map { Text($0.absoluteString) }

                                if viewStore.processingUUIDs.contains(viewStore.selectedRepository!.id) {
                                    ActivityIndicator(isAnimating: .constant(true), style: .spinning)
                                } else {
                                    viewStore.selectedRepository?.license?.name.map { Text($0) }
                                    viewStore.selectedRepository?.license?.decodedContent.map { Text($0) }
                                }
                            }
                            Spacer()
                        }
                        Spacer()
                    } else {
                        Text("Please select a repository...")
                    }
                }.padding()
            }.frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}

struct RepositoryDetail_Previews: PreviewProvider {
    static let decodedContent: String = """
        The MIT License (MIT)

        Copyright (c) 2019 XMARTLABS

        Permission is hereby granted, free of charge, to any person obtaining a copy
        of this software and associated documentation files (the "Software"), to deal
        in the Software without restriction, including without limitation the rights
        to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
        copies of the Software, and to permit persons to whom the Software is
        furnished to do so, subject to the following conditions:

        The above copyright notice and this permission notice shall be included in all
        copies or substantial portions of the Software.

        THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
        IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
        FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
        AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
        LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
        OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
        SOFTWARE.
    """

    static var previews: some View {
        RepositoryDetail()
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
                                url: URL(string: "https://github.com/xmartlabs/Eureka"),
                                license: .init(decodedContent: decodedContent)
                            )
                        ],
                        githubRequestStatus: nil,
                        progress: 0.5
                    ),
                    reducer: ReducerFactory.appReducer,
                    environment: AppEnvironment()
            )
        )
        .previewLayout(.fixed(width: 650, height: 500))
    }
}

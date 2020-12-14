//  Copyright © 2020 Andreas Link. All rights reserved.

import Cocoa
import Combine
import SwiftUI

struct DetailView: View {
    @EnvironmentObject private var store: Store<AppState, AppAction, AppEnvironment>

    var body: some View {
        Group {
            if let repository = store.state.selectedRepository {
                ScrollView {
                    VStack(alignment: .leading) {
                        HStack {
                            Spacer()
                        }.frame(height: 1)
                        DetailItemView(
                            title: L10n.Detail.ListEntry.Name.title,
                            content: repository.name
                        )
                        DetailItemView(
                            title: L10n.Detail.ListEntry.Version.title,
                            content: repository.version
                        )
                        DetailItemView(
                            title: L10n.Detail.ListEntry.PackageManager.title,
                            content: repository.packageManager.rawValue
                        )
                        repository.author.map { author in
                            DetailItemView(
                                title: L10n.Detail.ListEntry.Author.title,
                                content: author
                            )
                        }

                        repository.license?.license?.name.map { name in
                            DetailItemView(
                                title: L10n.Detail.ListEntry.LicenseName.title,
                                content: name
                            )
                        }

                        repository.license?.downloadURL.flatMap(URL.init(string:)).flatMap { url in
                            DetailItemView(
                                title: L10n.Detail.ListEntry.LicenseUrl.title,
                                content: url.absoluteString
                            )
                        }

                        repository.license?.decodedContent.map { content in
                            DetailItemView(
                                title: L10n.Detail.ListEntry.LicenseContent.title,
                                content: content
                            )
                        }
                    }
                }
                .padding(.leading, 16)
                .navigationTitle(repository.name)
            } else {
                DetailPlaceholderView()
            }
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
    }
}

struct RepositoryDetail_Previews: PreviewProvider {
    private static let repository: GithubRepository = .init(
        packageManager: .carthage,
        name: "Eureka",
        version: "5.2.1",
        author: "xmartlabs",
        url: URL(string: "https://github.com/xmartlabs/Eureka"),
        license: .init(
            downloadURL: "https://google.de",
            decodedContent: """
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
        )
    )

    static var previews: some View {
        return DetailView()
            .environmentObject(
                Store<AppState, AppAction, AppEnvironment>(
                    initialState: .init(
                        isProcessing: false,
                        isTargeted: false,
                        progress: 0.75,
                        remainingRepositories: 0,
                        totalRepositories: 0,
                        errorMessage: nil,
                        selection: repository.id,
                        repositories: [repository]
                    ),
                    reducer: appReducer,
                    environment: AppEnvironment()
                )
            )
            .previewLayout(.fixed(width: 450, height: 950))
    }
}

//  Copyright © 2020 Andreas Link. All rights reserved.

import Cocoa
import Combine
import ComposableArchitecture
import SwiftUI

struct RepositoryDetail: View {
    let store: Store<AppState, AppAction>

    var body: some View {
        GeometryReader { geometry in
            WithViewStore(store) { viewStore in
                Group {
                    if viewStore.selectedRepository != nil {
                        ScrollView(.vertical) {
                            HStack {
                                VStack(alignment: .leading) {
                                    ForEach(viewStore.detailListEntries!) { entry in
                                        HStack(alignment: .top) {
                                            Icon(name: entry.iconName, size: .init(width: 48, height: 48))
                                            VStack(alignment: .leading, spacing: 4) {
                                                Text(entry.title)
                                                    .font(.title)
                                                Text(entry.subtitle)
                                                    .font(.body)
                                            }.padding(.top, 0)
                                        }
                                        .padding()
                                    }
                                }
                                Spacer()
                            }
                        }
                        .padding(4)
                    } else {
                        RepositoryDetailPlaceholder()
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
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
        return RepositoryDetail(
            store: .init(
                initialState: .init(
                    isProcessing: false,
                    isTargeted: false,
                    progress: nil,
                    remainingRepositories: 0,
                    totalRepositories: 0,
                    errorMessage: nil,
                    selectedRepository: repository,
                    repositories: [repository]
                ),
                reducer: appReducer,
                environment: AppEnvironment()
            )
        )
        .previewLayout(.fixed(width: 850, height: 700))
    }
}

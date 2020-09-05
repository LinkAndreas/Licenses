//  Copyright © 2020 Andreas Link. All rights reserved.

import ComposableArchitecture
import SwiftUI

struct RepositoryMaster: View {
    let store: Store<AppState, AppAction>

    var body: some View {
        VStack(spacing: 0) {
            RepositoryListView(store: store)
            InformationView(store: store)
        }
        .frame(width: 400)
    }
}

struct RepositoryMaster_Previews: PreviewProvider {
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
        RepositoryMaster(
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
    }
}

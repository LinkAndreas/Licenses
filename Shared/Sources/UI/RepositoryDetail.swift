//  Copyright © 2020 Andreas Link. All rights reserved.

import SwiftUI

struct RepositoryDetail: View {
    @EnvironmentObject var store: WindowStore

    var body: some View {
        GeometryReader { geometry in
            Group {
                VStack {
                    if let selectedRepository = store.selectedRepository {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(selectedRepository.name)
                                Text(selectedRepository.version)
                                Text(selectedRepository.packageManager.rawValue)
                                selectedRepository.author.map { Text($0) }
                                // selectedRepository.url?.absoluteString.map { Text($0) }

                                if store.processingUUIDs.contains(selectedRepository.id) {
                                    ProgressView()
                                } else {
                                    selectedRepository.license?.name.map { Text($0) }
                                    selectedRepository.license?.decodedContent.map { Text($0) }
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
                WindowStore(
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
                    selectedRepository: nil,
                    githubRequestStatus: .init(limit: 40, remaining: 0, resetInterval: 30),
                    progress: 0.5
                )
            )
            .environmentObject(
                Store(
                    githubRequestStatus: .init(
                        limit: 40,
                        remaining: 0,
                        resetInterval: 30
                    )
                )
            )
            .previewLayout(.fixed(width: 650, height: 500))
    }
}

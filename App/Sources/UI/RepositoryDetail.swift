//  Copyright © 2020 Andreas Link. All rights reserved.

import Combine
import SwiftUI

struct RepositoryDetailListEntry: Identifiable {
    let iconName: String
    let title: String
    let subtitle: String

    var id: String {
        return title
    }
}

struct RepositoryDetail: View {
    @EnvironmentObject var store: Store

    var body: some View {
        GeometryReader { geometry in
            Group {
                if self.store.selectedRepository != nil {
                    List(self.store.detailListEntries!) { entry in
                        HStack {
                            Icon(name: entry.iconName, size: .init(width: 32, height: 32))
                            VStack(alignment: .leading) {
                                Text(entry.title)
                                    .font(.headline)
                                Text(entry.subtitle)
                                    .font(.subheadline)
                            }
                        }
                        .padding()
                    }
                    .padding(4)
                } else {
                    VStack(alignment: .center) {
                        Spacer()
                        VStack {
                            Icon(name: "box", size: .init(width: 100, height: 100))
                            Text("You can select manifests using File > Open File or drop them within this window.")
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: 300)
                        }
                        Spacer()
                    }
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
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
        return RepositoryDetail()
            .environmentObject(
                Store(
                    isTargeted: false,
                    progress: 0.5,
                    githubRequestStatus: .init(
                        limit: 40,
                        remaining: 0,
                        resetInterval: 30
                    ),
                    repositories: [repository],
                    selectedRepository: repository
                )
        )
        .previewLayout(.fixed(width: 850, height: 700))
    }
}

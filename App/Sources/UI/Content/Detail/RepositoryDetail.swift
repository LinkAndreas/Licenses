//  Copyright © 2020 Andreas Link. All rights reserved.

import Cocoa
import Combine
import SwiftUI

class RepositoryDetailListEntry: Identifiable {
    let iconName: String
    let title: String
    let subtitle: String
    var id: UUID

    init(
        iconName: String,
        title: String,
        subtitle: String,
        id: UUID = .init()
    ) {
        self.iconName = iconName
        self.title = title
        self.subtitle = subtitle
        self.id = id
    }
}

struct RepositoryDetail: View {
    @EnvironmentObject var store: Store

    var body: some View {
        GeometryReader { geometry in
            Group {
                if self.store.selectedRepository != nil {
                    ScrollView(.vertical) {
                        HStack {
                            VStack(alignment: .leading) {
                                ForEach(self.store.detailListEntries!) { entry in
                                    HStack(alignment: .top) {
                                        Icon(name: entry.iconName, size: .init(width: 32, height: 32))
                                            .padding(.top, 6)
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text(entry.title)
                                                .foregroundColor(.white)
                                                .font(.headline)
                                            Text(entry.subtitle)
                                                .font(.subheadline)
                                        }
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
                    errorMessage: "Test Error Message",
                    repositories: [repository],
                    selectedRepository: repository
                )
        )
        .previewLayout(.fixed(width: 850, height: 700))
    }
}

//  Copyright © 2020 Andreas Link. All rights reserved.

import Combine
import SwiftUI

struct RepositoryDetail: View {
    @EnvironmentObject var store: Store

    var body: some View {
        GeometryReader { geometry in
            Group {
                if self.store.selectedRepository != nil {
                    RepositoryDetailContentView(repository: self.store.selectedRepository!)
                } else {
                    RepositoryDetailPlaceholder()
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}

struct RepositoryDetailPlaceholder: View {
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            Text("You can select manifests using File > Open File or drop them within this window.")
            Spacer()
        }
    }
}

struct RepositoryDetailContentView: View {
    let repository: GithubRepository

    var body: some View {
        ScrollView {
            HStack {
                VStack {
                    HStack {
                        VStack(alignment: .leading, spacing: 16) {
                            HeaderView(repository: repository)
                            MetadataView(repository: repository)
                            LicenseView(repository: repository)
                        }
                    }
                    Spacer()
                }.padding()
                Spacer()
            }
        }
    }
}

struct HeaderView: View {
    let repository: GithubRepository

    var body: some View {
        Group {
            Text(repository.name)
                .font(.largeTitle)
        }
    }
}

struct LicenseView: View {
    let repository: GithubRepository

    var body: some View {
        Group {
            if repository.license != nil && repository.license!.decodedContent != nil {
                Text("License:")
                    .font(.headline)
                Text(repository.license!.decodedContent!)
                    .padding()
                    .background(Color(NSColor.darkGray))
                    .cornerRadius(5)
            }
        }
    }
}

struct MetadataView: View {
    let repository: GithubRepository

    var body: some View {
        Group {
            Text("Metadata:")
                .font(.headline)
            HStack {
                VStack(alignment: .leading) {
                    Text("Version:")
                        .font(.headline)
                    repository.author.map { _ in
                        Text("Author:")
                            .font(.headline)
                    }
                    Text("Package Manager:")
                        .font(.headline)
                }
                VStack(alignment: .trailing) {
                    Text(repository.version)
                        .font(.body)
                    repository.author.map { author in
                        Text(author)
                            .font(.body)
                    }
                    Text(repository.packageManager.rawValue)
                        .font(.body)
                }
            }
            .padding()
            .background(Color(NSColor.darkGray))
            .cornerRadius(5)
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

//  Copyright © 2020 Andreas Link. All rights reserved.

import SwiftUI

struct RepositoryListEntry: View {
    let viewModel: RepositoryListEntryViewModel

    var body: some View {
        HStack(alignment: .center) {
            if viewModel.showsProgressIndicator {
                #if os(macOS)
                ProgressIndicator()
                    .frame(width: 15, height: 15, alignment: .center)
                #endif
            }
            VStack(alignment: .leading) {
                viewModel.title.map { Text($0).font(.headline) }
                viewModel.subtitle.map { Text($0).font(.subheadline) }
            }
            Spacer()
            HStack {
                viewModel.caption.map { Text($0).font(.caption) }
            }
        }
        .padding(6)
    }
}

struct RepositoryListEntry_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RepositoryListEntry(
                viewModel: .init(
                    title: "Title",
                    subtitle: "Subtitle",
                    caption: "Caption",
                    showsProgressIndicator: true
                )
            )
            .previewLayout(.fixed(width: 550, height: 44))

            RepositoryListEntry(
                viewModel: .init(
                    title: "Title",
                    subtitle: "Subtitle",
                    caption: "Caption",
                    showsProgressIndicator: true
                )
            )
            .previewLayout(.fixed(width: 550, height: 44))

            RepositoryListEntry(viewModel: .init(title: "Title", subtitle: "Subtitle", caption: "Caption"))
                .previewLayout(.fixed(width: 550, height: 44))

            RepositoryListEntry(viewModel: .init(title: "Title"))
                .previewLayout(.fixed(width: 550, height: 44))

            RepositoryListEntry(viewModel: .init(subtitle: "Subtitle"))
                .previewLayout(.fixed(width: 550, height: 44))
        }
    }
}

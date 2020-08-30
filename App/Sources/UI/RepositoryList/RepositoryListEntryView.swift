//  Copyright © 2020 Andreas Link. All rights reserved.

import SwiftUI

struct RepositoryListEntryView: View {
    let viewModel: RepositoryListEntryViewModel

    var body: some View {
        HStack(alignment: .center) {
            if viewModel.showsProgressIndicator {
                ProgressIndicator()
                    .frame(width: 15, height: 15, alignment: .center)
            }
            VStack(alignment: .leading) {
                viewModel.title.map { Text($0).font(.body) }
                viewModel.subtitle.map { Text($0).font(.footnote) }
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
            RepositoryListEntryView(
                viewModel: .init(
                    title: "Title",
                    subtitle: "Subtitle",
                    caption: "Caption",
                    showsProgressIndicator: true
                )
            )
            .previewLayout(.fixed(width: 550, height: 44))

            RepositoryListEntryView(
                viewModel: .init(
                    title: "Title",
                    subtitle: "Subtitle",
                    caption: "Caption",
                    showsProgressIndicator: true
                )
            )
            .previewLayout(.fixed(width: 550, height: 44))

            RepositoryListEntryView(viewModel: .init(title: "Title", subtitle: "Subtitle", caption: "Caption"))
                .previewLayout(.fixed(width: 550, height: 44))

            RepositoryListEntryView(viewModel: .init(title: "Title"))
                .previewLayout(.fixed(width: 550, height: 44))

            RepositoryListEntryView(viewModel: .init(subtitle: "Subtitle"))
                .previewLayout(.fixed(width: 550, height: 44))
        }
    }
}

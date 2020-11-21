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
                viewModel.title.map { text in
                    Text(text)
                        .font(.headline)
                        .foregroundColor(Color(viewModel.titleColor))
                }
                viewModel.subtitle.map { text in
                    Text(text)
                        .font(.subheadline)
                        .foregroundColor(Color(viewModel.subtitleColor))
                }
            }
            Spacer()
            HStack {
                viewModel.caption.map { text in
                    Text(text)
                        .font(.callout)
                        .foregroundColor(Color(viewModel.captionColor))
                }
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

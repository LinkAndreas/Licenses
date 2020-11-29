//  Copyright © 2020 Andreas Link. All rights reserved.

import SwiftUI

struct RepositoryListEntryView: View {
    let entry: RepositoryListEntry

    var body: some View {
        HStack(alignment: .center) {
            if entry.showsProgressIndicator {
                ProgressIndicator()
                    .frame(width: 15, height: 15, alignment: .center)
            }
            VStack(alignment: .leading) {
                entry.title.map { text in
                    Text(text)
                        .font(.headline)
                        .foregroundColor(
                            Color(entry.isSelected ? .alternateSelectedControlTextColor : .labelColor)
                        )
                }
                entry.subtitle.map { text in
                    Text(text)
                        .font(.subheadline)
                        .foregroundColor(
                            Color(entry.isSelected ? .alternateSelectedControlTextColor : .secondaryLabelColor)
                        )
                }
            }
            Spacer()
            HStack {
                entry.caption.map { text in
                    Text(text)
                        .font(.callout)
                        .foregroundColor(
                            Color(entry.isSelected ? .alternateSelectedControlTextColor : .secondaryLabelColor)
                        )
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
                entry: .init(
                    title: "Title",
                    subtitle: "Subtitle",
                    caption: "Caption",
                    showsProgressIndicator: true
                )
            )
            .previewLayout(.fixed(width: 550, height: 44))

            RepositoryListEntryView(
                entry: .init(
                    title: "Title",
                    subtitle: "Subtitle",
                    caption: "Caption",
                    showsProgressIndicator: true
                )
            )
            .previewLayout(.fixed(width: 550, height: 44))

            RepositoryListEntryView(entry: .init(title: "Title", subtitle: "Subtitle", caption: "Caption"))
                .previewLayout(.fixed(width: 550, height: 44))

            RepositoryListEntryView(entry: .init(title: "Title"))
                .previewLayout(.fixed(width: 550, height: 44))

            RepositoryListEntryView(entry: .init(subtitle: "Subtitle"))
                .previewLayout(.fixed(width: 550, height: 44))
        }
    }
}

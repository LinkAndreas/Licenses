//  Copyright © 2021 Andreas Link. All rights reserved.

import SwiftUI

struct DetailPlaceholderEntryView: View {
    let entry: DetailPlaceholderEntry

    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                Text(entry.title)
                    .font(.headline)
                    .foregroundColor(Color(NSColor.labelColor))
                Text(entry.subtitle)
                    .font(.subheadline)
                    .foregroundColor(Color(NSColor.secondaryLabelColor))
            }
            Spacer()
            HStack {
                Text(entry.caption)
                    .font(.callout)
                    .foregroundColor(Color(NSColor.secondaryLabelColor))
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(Asset.Colors.placeholderItemBackgroundColor.color))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .strokeBorder(Color(Asset.Colors.placeholderItemBorderColor.color), lineWidth: 2)
        )
        .frame(width: 300)
        .redacted(reason: .placeholder)
    }
}

struct DetailPlaceholderEntryView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DetailPlaceholderEntryView(
                entry: .init(
                    title: "Title",
                    subtitle: "Subtitle",
                    caption: "Caption"
                )
            )
            .previewLayout(.fixed(width: 300, height: 90))
            DetailPlaceholderEntryView(
                entry: .init(
                    title: "Title",
                    subtitle: "Subtitle",
                    caption: "Caption"
                )
            )
            .preferredColorScheme(.dark)
            .previewLayout(.fixed(width: 300, height: 90))
        }
    }
}

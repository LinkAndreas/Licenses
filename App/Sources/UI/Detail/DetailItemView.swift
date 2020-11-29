//  Copyright © 2020 Andreas Link. All rights reserved.

import SwiftUI

struct DetailItemView: View {
    let title: String
    let content: String
    let systemImage: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Label(title, systemImage: systemImage)
                .font(.headline)
                .foregroundColor(Color(NSColor.labelColor))
            Text(content)
                .font(.body)
                .foregroundColor(Color(NSColor.secondaryLabelColor))
                .lineLimit(nil)
        }
        .padding([.bottom, .top], 4)
    }
}

struct DetailItemView_Previews: PreviewProvider {
    static var previews: some View {
        DetailItemView(title: "Title", content: "Content", systemImage: "gear")
    }
}

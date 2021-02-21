//  Copyright © 2021 Andreas Link. All rights reserved.

import SwiftUI

struct DetailListView: View {
    @ObservedObject var store: ViewStore<DetailListViewState, Never>

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                }.frame(height: 1)
                ForEach(store.items) { item in
                    DetailItemView(
                        title: item.title,
                        content: item.content
                    )
                }
            }
        }
        .padding(.horizontal, 16)
    }
}

struct DetailListView_Previews: PreviewProvider {
    static var previews: some View {
        DetailListView(store: .constant(state: PreviewData.DetailList.state))
            .previewLayout(.fixed(width: 450, height: 780))
    }
}

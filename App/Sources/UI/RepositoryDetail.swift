//  Copyright © 2020 Andreas Link. All rights reserved.

import ComposableArchitecture
import SwiftUI

struct RepositoryDetail: View {
    let store: Store<AppState, AppAction>

    var body: some View {
        GeometryReader { geometry in
            WithViewStore(self.store) { viewStore in
                if viewStore.selectedRepository != nil {
                    VStack {
                        HStack {
                            VStack(alignment: .leading) {
                                viewStore.selectedRepository.map { Text($0.name) }
                                viewStore.selectedRepository.map { Text($0.version) }
                                viewStore.selectedRepository?.author.map { Text($0) }
                                viewStore.selectedRepository?.url.map { Text($0.absoluteString) }
                                viewStore.selectedRepository?.license?.name.map { Text($0) }
                                viewStore.selectedRepository?.license?.decodedContent.map { Text($0) }
                            }
                            Spacer()
                        }
                        Spacer()
                    }.padding()
                } else {
                    Text("Please select a repository...")
                }
            }.frame(width: geometry.size.width, height: geometry.size.width)
        }
    }
}

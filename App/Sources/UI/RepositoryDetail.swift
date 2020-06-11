//  Copyright © 2020 Andreas Link. All rights reserved.

import SwiftUI

struct RepositoryDetail: View {
    @EnvironmentObject var store: Store<AppState, AppAction, AppEnvironment>

    var body: some View {
        GeometryReader { geometry in
            ViewStoreProvider(self.store) { viewStore in
                VStack {
                    if viewStore.selectedRepository != nil {
                        HStack {
                            VStack(alignment: .leading) {
                                viewStore.selectedRepository.map { Text($0.name) }
                                viewStore.selectedRepository.map { Text($0.version) }
                                viewStore.selectedRepository.map { Text($0.packageManager.rawValue) }
                                viewStore.selectedRepository?.author.map { Text($0) }
                                viewStore.selectedRepository?.url.map { Text($0.absoluteString) }

                                if viewStore.selectedRepository?.license == nil {
                                    ActivityIndicator(isAnimating: .constant(true), style: .spinning)
                                } else {
                                    viewStore.selectedRepository?.license?.name.map { Text($0) }
                                    viewStore.selectedRepository?.license?.decodedContent.map { Text($0) }
                                }
                            }
                            Spacer()
                        }
                        Spacer()
                    } else {
                        Text("Please select a repository...")
                    }
                }.padding()
            }.frame(width: geometry.size.width, height: geometry.size.width)
        }
    }
}

//  Copyright © 2021 Andreas Link. All rights reserved.

import Combine
import SwiftUI

struct FileDropArea<Content: View>: View {
    @ObservedObject var store: ViewStore<FileDropAreaViewState, FileDropAreaViewAction>

    private let content: () -> Content

    init(
        store: ViewStore<FileDropAreaViewState, FileDropAreaViewAction>,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self._store = .init(initialValue: store)
        self.content = content
    }

    var body: some View {
        GeometryReader { geometry in
            Group {
                VStack {
                    self.content()
                        .onDrop(
                            of: ["public.file-url"],
                            isTargeted: store.binding(
                                get: \.isTargeted,
                                send: { isTargeted in .didUpdateIsTargeted(isTargeted) }
                            )
                        ) { providers -> Bool in
                            store.send(.didSelectProviders(providers))
                            return true
                        }
                        .border(store.isTargeted ? Color.red : Color.clear)
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
    }
}

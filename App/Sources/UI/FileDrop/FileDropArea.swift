//  Copyright © 2020 Andreas Link. All rights reserved.

import Combine
import ComposableArchitecture
import SwiftUI

struct FileDropArea<Content: View>: View {
    let store: Store<AppState, AppAction>

    private let content: () -> Content

    init(store: Store<AppState, AppAction>, @ViewBuilder content: @escaping () -> Content) {
        self.store = store
        self.content = content
    }

    var body: some View {
        WithViewStore(store) { viewStore in
            GeometryReader { geometry in
                Group {
                    VStack {
                        self.content()
                            .onDrop(
                                of: ["public.file-url"],
                                isTargeted: viewStore.binding(
                                    get: { $0.isTargeted },
                                    send: { AppAction.updateIsTargeted(value: $0) }
                                )
                            ) { providers -> Bool in
                                viewStore.send(.handle(providers: providers))
                                return true
                            }
                        .border(viewStore.isTargeted ? Color.red : Color.clear)
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height)
                }
            }
        }
    }
}

//  Copyright © 2020 Andreas Link. All rights reserved.

import Combine
import SwiftUI

struct FileDropArea<Content: View>: View {
    @EnvironmentObject var store: Store<AppState, AppAction, AppEnvironment>

    private let content: () -> Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    var body: some View {
        GeometryReader { geometry in
            Group {
                VStack {
                    self.content()
                        .onDrop(
                            of: ["public.file-url"],
                            isTargeted: Binding<Bool>(
                                get: { store.state.isTargeted },
                                set: { isTargeted in store.send(.updateIsTargeted(value: isTargeted)) }
                            )
                        ) { providers -> Bool in
                            store.send(.handle(providers: providers))
                            return true
                        }
                        .border(store.state.isTargeted ? Color.red : Color.clear)
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
    }
}

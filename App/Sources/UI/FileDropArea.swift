//  Copyright © 2020 Andreas Link. All rights reserved.

import Cocoa
import Combine
import ComposableArchitecture
import SwiftUI

struct FileDropArea<Content: View>: View {
    let store: Store<AppState, AppAction>
    private var content: () -> Content

    init(store: Store<AppState, AppAction>, @ViewBuilder content: @escaping () -> Content) {
        self.store = store
        self.content = content
    }

    var body: some View {
        GeometryReader { geometry in
            WithViewStore(self.store) { viewStore in
                VStack {
                    self.content()
                        .onDrop(
                            of: ["public.file-url"],
                            isTargeted: viewStore.binding(get: { $0.isTargeted }, send: { .changeIsTargeted($0) })
                        ) { providers -> Bool in
                            providers.first?.loadDataRepresentation(
                                forTypeIdentifier: "public.file-url",
                                completionHandler: { data, _ in
                                    guard
                                        let data = data,
                                        let path = NSString(data: data, encoding: 4),
                                        let url = URL(string: path as String)
                                    else { return }

                                    viewStore.send(.searchManifests(path: url))
                                }
                            )
                            return true
                        }
                        .border(viewStore.isTargeted ? Color.red : Color.clear)
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}

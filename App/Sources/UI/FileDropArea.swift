//  Copyright © 2020 Andreas Link. All rights reserved.

import Combine
import SwiftUI

struct FileDropArea<Content: View>: View {
    @EnvironmentObject var store: Store<AppState, AppAction, AppEnvironment>

    private var content: () -> Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    var body: some View {
        GeometryReader { geometry in
            ViewStoreProvider(self.store) { viewStore in
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

                                    DispatchQueue.main.async {
                                        self.store.send(.searchManifests(path: url))
                                    }
                                }
                            )
                            return true
                        }
                    .border(viewStore.isTargeted ? Color.red : Color.clear)
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
    }
}

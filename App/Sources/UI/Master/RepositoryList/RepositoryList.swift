//  Copyright © 2020 Andreas Link. All rights reserved.

import AppKit
import SwiftUI

struct RepositoryList: View {
    @EnvironmentObject private var store: Store<AppState, AppAction, AppEnvironment>

    @Binding var selection: UUID?

    var body: some View {
        List(selection: $selection) {
            ForEach(store.state.listEntries) { entry in
                RepositoryListEntryView(entry: entry)
                    .tag(entry.id)
                    .animation(nil)
            }
        }
        .animation(.default)
    }
}

//  Copyright © 2020 Andreas Link. All rights reserved.

import Foundation
import SwiftUI

struct ViewStoreProvider<State, Action, Environment, Content>: View where Content: View {
    private let content: (ViewStore<State, Action, Environment>) -> Content

    @ObservedObject private var viewStore: ViewStore<State, Action, Environment>

    init(
        _ store: Store<State, Action, Environment>,
        removeDuplicates isDuplicate: @escaping (State, State) -> Bool,
        @ViewBuilder content: @escaping (ViewStore<State, Action, Environment>) -> Content
    ) {
        self.content = content
        self.viewStore = ViewStore(store, removeDuplicates: isDuplicate)
    }

    var body: some View {
        content(viewStore)
    }
}

extension ViewStoreProvider where State: Equatable {
    init(
        _ store: Store<State, Action, Environment>,
        @ViewBuilder content: @escaping (ViewStore<State, Action, Environment>) -> Content
    ) {
        self.init(store, removeDuplicates: ==, content: content)
    }
}

extension ViewStoreProvider where State == Void {
    init(
        _ store: Store<State, Action, Environment>,
        @ViewBuilder content: @escaping (ViewStore<State, Action, Environment>) -> Content
    ) {
        self.init(store, removeDuplicates: ==, content: content)
    }
}

extension ViewStoreProvider: DynamicViewContent where State: Collection, Content: DynamicViewContent {
    typealias Data = State

    var data: State {
        self.viewStore.state
    }
}

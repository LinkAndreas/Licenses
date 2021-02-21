//  Copyright © 2021 Andreas Link. All rights reserved.

import SwiftUI

struct ViewStoreProvider<State: Equatable, Action, Content: View>: View {
    private let content: (ViewStore<State, Action>) -> Content
    private let store: ViewStore<State, Action>

    init(
        statePublisher: AnyStatePublisher<State>,
        actionReceiver: AnyActionReceiver<Action>,
        @ViewBuilder content: @escaping (ViewStore<State, Action>) -> Content
    ) {
        self.store = ViewStore<State, Action>(
            statePublisher: AnyStatePublisher(publisher: statePublisher),
            actionReceiver: AnyActionReceiver(receiver: actionReceiver)
        )

        self.content = content
    }

    var body: some View {
        content(store)
    }
}

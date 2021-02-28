//  Copyright © 2021 Andreas Link. All rights reserved.

import SwiftUI

struct ViewStoreWithNonOptionalStateProvider<State: Equatable, Action, Content: View>: View {
    private let content: (ViewStore<State?, Action>) -> Content
    private let store: ViewStore<State?, Action>

    init<TargetContent, FallbackContent>(
        from store: ViewStore<State?, Action>,
        success targetContent: @escaping (ViewStore<State, Action>) -> TargetContent,
        failure fallbackContent: @escaping @autoclosure () -> FallbackContent
    ) where Content == _ConditionalContent<TargetContent, FallbackContent> {
        self.store = store
        self.content = { store in
            if let state = store.state {
                return ViewBuilder.buildEither(first: targetContent(store.derived(stateMapper: { $0 ?? state })))
            } else {
                return ViewBuilder.buildEither(second: fallbackContent())
            }
        }
    }

    init<TargetContent>(
        from store: ViewStore<State?, Action>,
        success targetContent: @escaping (ViewStore<State, Action>) -> TargetContent
    ) where Content == TargetContent? {
        self.store = store
        self.content = { store in
            guard let state = store.state else { return nil }

            return targetContent(store.derived(stateMapper: { $0 ?? state }))
        }
    }

    var body: some View {
        ViewStoreProvider(
            statePublisher: AnyStatePublisher(publisher: store),
            actionReceiver: AnyActionReceiver(receiver: store)
        ) { store in
            content(store)
        }
    }
}

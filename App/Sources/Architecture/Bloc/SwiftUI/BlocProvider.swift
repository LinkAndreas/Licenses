//  Copyright © 2021 Andreas Link. All rights reserved.

import Combine
import SwiftUI

struct BlocProvider<State: Equatable, Action, Environment>: View {
    @StateObject private var bloc: Bloc<State, Action, Environment>

    private let content: AnyView

    init<Content: View>(
        initialState: State,
        reducer: AnyBlocReducer<State, Action, Environment>,
        environment: Environment,
        @ViewBuilder content: @escaping (Bloc<State, Action, Environment>) -> Content
    ) {
        let bloc: Bloc<State, Action, Environment> = .init(
            initialState: initialState,
            reducer: reducer,
            environment: environment
        )

        self._bloc = .init(wrappedValue: bloc)
        self.content = content(bloc).eraseToAnyView()
    }

    var body: some View {
        content
    }
}

//  Copyright © 2020 Andreas Link. All rights reserved.

import Combine

struct Reducer<State, Action, Environment> {
    private let reducer: (inout State, Action, Environment) -> SideEffect<Action, Never>

    init(_ reducer: @escaping (inout State, Action, Environment) -> SideEffect<Action, Never>) {
        self.reducer = reducer
    }

    func run(
        _ state: inout State,
        _ action: Action,
        _ environment: Environment
    ) -> SideEffect<Action, Never> {
        self.reducer(&state, action, environment)
    }
}

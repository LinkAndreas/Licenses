//  Copyright © 2021 Andreas Link. All rights reserved.

import Combine

protocol BlocReducer {
    associatedtype State: Equatable
    associatedtype Action
    associatedtype Environment

    func reduce(state: inout State, action: Action, environment: Environment) -> Effect<Action, Never>
    func eraseToAnyBlocReducer() -> AnyBlocReducer<State, Action, Environment>
}

extension BlocReducer {
    func eraseToAnyBlocReducer() -> AnyBlocReducer<State, Action, Environment> {
        return .init(reducer: self)
    }
}

struct AnyBlocReducer<State: Equatable, Action, Environment> {
    private let _reduce: (inout State, Action, Environment) -> Effect<Action, Never>

    init<Reducer: BlocReducer>(
        reducer: Reducer
    ) where Reducer.State == State, Reducer.Action == Action, Reducer.Environment == Environment {
        self._reduce = reducer.reduce
    }

    func reduce(state: inout State, action: Action, environment: Environment) -> Effect<Action, Never> {
        _reduce(&state, action, environment)
    }
}

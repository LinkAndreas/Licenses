//  Copyright © 2021 Andreas Link. All rights reserved.

import Combine
import Foundation

final class Bloc<State: Equatable, Action, Environment>: ObservableObject, ActionReceiver, StatePublisher {
    @Published var state: State

    var statePublisher: AnyPublisher<State, Never> { $state.eraseToAnyPublisher() }

    private let reducer: AnyBlocReducer<State, Action, Environment>
    private let environment: Environment
    private var cancellables: Set<AnyCancellable> = []

    init(
        initialState: State,
        reducer: AnyBlocReducer<State, Action, Environment>,
        environment: Environment
    ) {
        self.state = initialState
        self.reducer = reducer
        self.environment = environment
    }

    func send(_ action: Action) {
        let effect = reducer.reduce(state: &state, action: action, environment: environment)

        effect
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: send)
            .store(in: &cancellables)
    }

    func viewStore<DerivedState: Equatable, ExtractedAction>(
        stateMapper: @escaping (State) -> DerivedState,
        actionMapper: @escaping (ExtractedAction) -> Action
    ) -> ViewStore<DerivedState, ExtractedAction> {
        let store: ViewStore<DerivedState, ExtractedAction> = .init(
            statePublisher: AnyStatePublisher(publisher: self, stateMapper: stateMapper),
            actionReceiver: AnyActionReceiver(receiver: self, actionMapper: actionMapper)
        )

        self.$state.map(stateMapper).assign(to: &store.$state)
        return store
    }
}

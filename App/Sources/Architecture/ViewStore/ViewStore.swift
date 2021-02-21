//  Copyright © 2021 Andreas Link. All rights reserved.

import Combine

@dynamicMemberLookup
final class ViewStore<State: Equatable, Action>: ObservableObject, ActionReceiver, StatePublisher {
    @Published var state: State

    var statePublisher: AnyPublisher<State, Never> { $state.eraseToAnyPublisher() }

    private let _statePublisher: AnyStatePublisher<State>!
    private let _actionReceiver: AnyActionReceiver<Action>!

    static func constant(state: State) -> ViewStore<State, Action> {
        return .init(state: state)
    }

    init(
        statePublisher: AnyStatePublisher<State>,
        actionReceiver: AnyActionReceiver<Action>
    ) {
        self.state = statePublisher.state
        self._statePublisher = statePublisher
        self._actionReceiver = actionReceiver

        statePublisher
            .statePublisher
            .removeDuplicates()
            .assign(to: &$state)
    }

    /**
     Only meant for rendering Previews.
        - Parameter state: The state of the view to preview
     */
    init(state: State) {
        _statePublisher = nil
        _actionReceiver = nil
        _state = .init(initialValue: state)
    }

    func send(_ action: Action) {
        guard let receiver = _actionReceiver else { return }

        receiver.send(action)
    }

    subscript<LocalState>(dynamicMember keyPath: KeyPath<State, LocalState>) -> LocalState {
        self.state[keyPath: keyPath]
    }

    func derived<DerivedState: Equatable, ExtractedAction>(
        stateMapper: @escaping (State) -> DerivedState,
        actionMapper: @escaping (ExtractedAction) -> Action
    ) -> ViewStore<DerivedState, ExtractedAction> {
        return .init(
            statePublisher: AnyStatePublisher(publisher: self, stateMapper: stateMapper),
            actionReceiver: AnyActionReceiver(receiver: self, actionMapper: actionMapper)
        )
    }

    func derived<DerivedState: Equatable>(
        stateMapper: @escaping (State) -> DerivedState
    ) -> ViewStore<DerivedState, Action> {
        self.derived(stateMapper: stateMapper, actionMapper: { $0 })
    }

    var withoutActions: ViewStore<State, Never> {
        func ignore<A>(_ never: Never) -> A {}

        return derived(stateMapper: { $0 }, actionMapper: ignore)
    }
}

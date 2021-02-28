//  Copyright © 2021 Andreas Link. All rights reserved.

import Combine

protocol ActionReceiver {
    associatedtype Action

    func send(_ action: Action)
}

protocol StatePublisher {
    associatedtype State: Equatable

    var state: State { get }
    var statePublisher: AnyPublisher<State, Never> { get }
}

struct AnyStatePublisher<State: Equatable>: StatePublisher {
    var state: State { getState() }
    var statePublisher: AnyPublisher<State, Never>

    private let getState: () -> State

    init<Publisher: StatePublisher>(publisher: Publisher) where Publisher.State == State {
        self.statePublisher = publisher.statePublisher.eraseToAnyPublisher()
        self.getState = { publisher.state }
    }

    init<Publisher: StatePublisher, ParentState>(
        publisher: Publisher,
        stateMapper: @escaping (ParentState) -> State
    ) where Publisher.State == ParentState {
        self.statePublisher = publisher.statePublisher.map(stateMapper).eraseToAnyPublisher()
        self.getState = { stateMapper(publisher.state) }
    }
}

struct AnyActionReceiver<Action>: ActionReceiver {
    private let _send: (Action) -> Void
    private var cancellables: Set<AnyCancellable> = .init()

    init<Receiver: ActionReceiver>(receiver: Receiver) where Receiver.Action == Action {
        self._send = { action in receiver.send(action) }
    }

    init<Receiver: ActionReceiver, ParentAction>(
        receiver: Receiver,
        actionMapper: @escaping (Action) -> ParentAction
    ) where Receiver.Action == ParentAction {
        self._send = { action in receiver.send(actionMapper(action)) }
    }

    func send(_ action: Action) {
        _send(action)
    }
}

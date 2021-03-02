//  Copyright © 2021 Andreas Link. All rights reserved.

import Combine

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

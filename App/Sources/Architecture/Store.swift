//  Copyright © 2020 Andreas Link. All rights reserved.

import Combine
import Foundation
import SwiftUI

final class Store<State, Action, Environment>: ObservableObject {
    @Published private(set) var state: State

    private let reducer: Reducer<State, Action, Environment>
    private let environment: Environment
    private var cancellables: Set<AnyCancellable> = .init()
    private var isProcessingAction: Bool = false
    private var actionSubject: PassthroughSubject<Action, Never> = .init()

    init(
        initialState: State,
        reducer: Reducer<State, Action, Environment>,
        environment: Environment
    ) {
        self.state = initialState
        self.reducer = reducer
        self.environment = environment

        setupPublishers()
    }

    func setupPublishers() {
        actionSubject
            .flatMap { self.reducer.run(&self.state, $0, self.environment) }
            .receive(on: RunLoop.main)
            .sink(receiveValue: actionSubject.send)
            .store(in: &cancellables)
    }

    func send(_ action: Action) {
        actionSubject.send(action)
    }
}

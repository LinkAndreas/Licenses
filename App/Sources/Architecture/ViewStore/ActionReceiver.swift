//  Copyright © 2021 Andreas Link. All rights reserved.

import Combine

protocol ActionReceiver {
    associatedtype Action

    func send(_ action: Action)
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

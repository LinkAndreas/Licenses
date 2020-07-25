//  Copyright © 2020 Andreas Link. All rights reserved.

import Combine
import Foundation
import SwiftUI

@dynamicMemberLookup
final class ViewStore<State, Action, Environment>: ObservableObject {
    @Published private(set) var state: State
    private let publisher: AnyPublisher<State, Never>
    private let sendActionHandler: (Action) -> Void
    private var cancellables: Set<AnyCancellable> = .init()

    init(
        _ store: Store<State, Action, Environment>,
        removeDuplicates isDuplicate: @escaping (State, State) -> Bool
    ) {
        publisher = store.$state.removeDuplicates(by: isDuplicate).eraseToAnyPublisher()
        state = store.state
        sendActionHandler = store.send
        publisher.assign(to: \.state, on: self).store(in: &cancellables)
    }

    subscript<LocalState>(dynamicMember keyPath: KeyPath<State, LocalState>) -> LocalState {
        state[keyPath: keyPath]
    }

    func send(_ action: Action) {
        sendActionHandler(action)
    }
}

extension ViewStore where State: Equatable {
    convenience init(_ store: Store<State, Action, Environment>) {
        self.init(store, removeDuplicates: ==)
    }
}

extension ViewStore {
    func binding<LocalState>(
        get: @escaping (State) -> LocalState,
        send localStateToViewAction: @escaping (LocalState) -> Action
    ) -> Binding<LocalState> {
        Binding(
            get: { get(self.state) },
            set: { newLocalState, transaction in
                withAnimation(transaction.disablesAnimations ? nil : transaction.animation) {
                    self.send(localStateToViewAction(newLocalState))
                }
            }
        )
    }

    func binding<LocalState>(
        get: @escaping (State) -> LocalState,
        send action: Action
    ) -> Binding<LocalState> {
        self.binding(get: get, send: { _ in action })
    }

    func binding(
        send localStateToViewAction: @escaping (State) -> Action
    ) -> Binding<State> {
        self.binding(get: { $0 }, send: localStateToViewAction)
    }

    func binding(send action: Action) -> Binding<State> {
        self.binding(send: { _ in action })
    }
}

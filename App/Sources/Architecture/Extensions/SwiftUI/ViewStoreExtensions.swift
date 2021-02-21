//  Copyright © 2021 Andreas Link. All rights reserved.

import SwiftUI

extension ViewStore {
    func binding<LocalState>(
        get: @escaping (State) -> LocalState,
        send localStateToViewAction: @escaping (LocalState) -> Action
    ) -> Binding<LocalState> {
        return .init(
            get: { get(self.state) },
            set: { newLocalState, transaction in
                if transaction.animation != nil {
                    withTransaction(transaction) {
                        self.send(localStateToViewAction(newLocalState))
                    }
                } else {
                    self.send(localStateToViewAction(newLocalState))
                }
            }
        )
    }
}

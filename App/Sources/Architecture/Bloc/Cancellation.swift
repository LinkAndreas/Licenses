//  Copyright © 2021 Andreas Link. All rights reserved.

import Combine

var cancellables: [AnyHashable: AnyCancellable] = [:]

extension Effect {
    func cancellable<Id: Hashable>(id: Id) -> Effect {
        return Deferred { () -> PassthroughSubject<Output, Failure> in
            cancellables[id]?.cancel()
            let subject = PassthroughSubject<Output, Failure>()
            cancellables[id] = self.subscribe(subject)
            return subject
        }
        .eraseToEffect()
    }

    static func cancel<Id: Hashable>(id: Id) -> Effect {
        .asyncTask {
            cancellables[id]?.cancel()
        }
    }
}

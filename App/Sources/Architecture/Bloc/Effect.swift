//  Copyright © 2021 Andreas Link. All rights reserved.

import Combine
import Foundation

struct Effect<Output, Failure: Error>: Publisher {
    let upstream: AnyPublisher<Output, Failure>
    let id: AnyHashable

    init<P: Publisher>(_ publisher: P, id: AnyHashable = UUID()) where P.Output == Output, P.Failure == Failure {
        self.upstream = publisher.eraseToAnyPublisher()
        self.id = id
    }

    init(value: Output, id: AnyHashable = UUID()) {
        self.init(Just(value).setFailureType(to: Failure.self), id: id)
    }

    init(error: Failure, id: AnyHashable = UUID()) {
        self.init(Fail(error: error), id: id)
    }

    func receive<S>(
        subscriber: S
    ) where S: Combine.Subscriber, Failure == S.Failure, Output == S.Input {
        self.upstream.subscribe(subscriber)
    }

    static var none: Effect {
        Empty(completeImmediately: true).eraseToEffect()
    }

    static func asyncTask(_ work: @escaping () -> Void) -> Effect {
        Deferred { () -> Effect in
            work()
            return .none
        }
        .eraseToEffect()
    }

    static func future(_ attemptToFulfill: @escaping (@escaping (Result<Output, Failure>) -> Void) -> Void) -> Effect {
        Deferred {
            Future { resolve in
                attemptToFulfill { result in resolve(result) }
            }
        }
        .eraseToEffect()
    }
}

extension Effect {
    static func merge(_ effects: Effect...) -> Effect {
        .merge(effects)
    }

    static func merge<S: Sequence>(_ effects: S) -> Effect where S.Element == Effect {
        Publishers.MergeMany(effects).eraseToEffect()
    }

    static func concatenate(_ effects: Effect...) -> Effect {
        .concatenate(effects)
    }

    static func concatenate<C: Collection>(
        _ effects: C
    ) -> Effect where C.Element == Effect {
        return effects.reduce(.none) { effects, effect in
            effects.append(effect).eraseToEffect()
        }
    }
}

//  Copyright © 2020 Andreas Link. All rights reserved.

import Combine
import Foundation

struct SideEffect<Output, Failure: Error>: Publisher {
    let upstream: AnyPublisher<Output, Failure>

    func receive<S: Subscriber>(subscriber: S) where Failure == S.Failure, Output == S.Input {
        upstream.subscribe(subscriber)
    }

    init<P: Publisher>(_ publisher: P) where P.Output == Output, P.Failure == Failure {
        self.upstream = publisher.receive(on: RunLoop.main).eraseToAnyPublisher()
    }
}

extension SideEffect {
    static func error(_ error: Failure) -> SideEffect {
        .init(Fail(error: error).eraseToAnyPublisher())
    }

    static func action(_ action: Output) -> SideEffect {
        return Just(action).setFailureType(to: Failure.self).eraseToSideEffect()
    }

    static var none: SideEffect {
        return .init(Empty(completeImmediately: true).eraseToAnyPublisher())
    }
}

extension SideEffect {
    func map<T>(_ transform: @escaping (Output) -> T) -> SideEffect<T, Failure> {
        .init(self.map(transform) as Publishers.Map<Self, T>)
    }

    static func concatenate(_ sideEffects: SideEffect...) -> SideEffect {
        .concatenate(sideEffects)
    }

    static func concatenate<C: Collection>(_ sideEffects: C) -> SideEffect where C.Element == SideEffect {
        guard let first = sideEffects.first else { return .none }

        return
            sideEffects
                .suffix(sideEffects.count - 1)
                .reduce(into: first, { $0 = $0.append($1).eraseToSideEffect() })
    }

    static func merge(_ sideEffects: SideEffect...) -> SideEffect {
        .merge(sideEffects)
    }

    static func merge<S: Sequence>(_ sideEffects: S) -> SideEffect where S.Element == SideEffect {
        Publishers.MergeMany(sideEffects).eraseToSideEffect()
    }
}

extension SideEffect {
    static func fireAndForget(_ work: @escaping () -> Void) -> SideEffect {
        Deferred { () -> Empty<Output, Failure> in
            work()
            return Empty(completeImmediately: true)
        }
        .eraseToSideEffect()
    }

    static func result(_ attemptToFulfill: @escaping () -> Result<Output, Failure>) -> SideEffect {
        Deferred { Future { $0(attemptToFulfill()) } }.eraseToSideEffect()
    }

    static func future(
        _ attemptToFulfill: @escaping (@escaping (Result<Output, Failure>) -> Void) -> Void
    ) -> SideEffect {
        Deferred {
            Future { callback in
                attemptToFulfill { result in callback(result) }
            }
        }
        .eraseToSideEffect()
    }
}

extension Publisher {
    func eraseToSideEffect() -> SideEffect<Output, Failure> {
        SideEffect(self)
    }
}

var cancellables: [AnyHashable: AnyCancellable] = [:]
let lock: NSRecursiveLock = .init()

extension SideEffect {
    func cancellable(id: AnyHashable) -> SideEffect {
        return Deferred { () -> Publishers.HandleEvents<PassthroughSubject<Output, Failure>> in
            lock.lock()
            defer { lock.unlock() }

            let subject: PassthroughSubject<Output, Failure> = .init()
            let cancellable: AnyCancellable = self.subscribe(subject)

            cancellables[id] = cancellable

            return subject.handleEvents(
                receiveCompletion: { _ in cancellable.cancel() },
                receiveCancel: cancellable.cancel
            )
        }.eraseToSideEffect()
    }

    static func cancel(id: AnyHashable) -> SideEffect {
      return .fireAndForget {
        lock.lock()
        cancellables[id]?.cancel()
        cancellables[id] = nil
        lock.unlock()
      }
    }
}

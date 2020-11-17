//  Copyright © 2020 Andreas Link. All rights reserved.

import Combine

typealias Reducer<State, Action, Environment> = (inout State, Action, Environment) -> AnyPublisher<Action, Never>?

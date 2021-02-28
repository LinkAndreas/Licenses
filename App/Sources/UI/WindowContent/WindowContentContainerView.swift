//  Copyright © 2021 Andreas Link. All rights reserved.

import SwiftUI

struct WindowContentContainerView: View {
    var body: some View {
        BlocProvider<AppState, AppAction, AppEnvironment>(
            initialState: .initial,
            reducer: AppReducer().eraseToAnyBlocReducer(),
            environment: DefaultEnvironment()
        ) { bloc in
            ViewStoreProvider(
                statePublisher: AnyStatePublisher(
                    publisher: bloc,
                    stateMapper: WindowContentViewStateMapper.map(state:)
                ),
                actionReceiver: AnyActionReceiver(
                    receiver: bloc,
                    actionMapper: WindowContentViewActionMapper.map(action:)
                )
            ) { store in
                WindowContentView(store: store)
            }
        }
    }
}

struct WindowView_Previews: PreviewProvider {
    static var previews: some View {
        WindowContentContainerView()
    }
}

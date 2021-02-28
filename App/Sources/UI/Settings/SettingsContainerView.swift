//  Copyright © 2021 Andreas Link. All rights reserved.

import SwiftUI

struct SettingsContainerView: View {
    var body: some View {
        BlocProvider<SettingsState, SettingsAction, SettingsEnvironment>(
            initialState: .initial,
            reducer: SettingsReducer().eraseToAnyBlocReducer(),
            environment: SettingsEnvironment()
        ) { bloc in
            ViewStoreProvider(
                statePublisher: AnyStatePublisher(
                    publisher: bloc,
                    stateMapper: SettingsViewStateMapper.map(state:)
                ),
                actionReceiver: AnyActionReceiver(
                    receiver: bloc,
                    actionMapper: SettingsViewActionMapper.map(action:)
                )
            ) { store in
                SettingsView(store: store)
            }
        }
    }
}

struct SettingsContainerView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsContainerView()
    }
}

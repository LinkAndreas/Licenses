//  Copyright © 2021 Andreas Link. All rights reserved.

import SwiftUI

struct WindowContentView: View {
    @ObservedObject var store: ViewStore<WindowContentViewState, WindowContentViewAction>

    var body: some View {
        FileDropArea(
            store: store.derived(
                stateMapper: \.fileDropAreaState,
                actionMapper: WindowContentViewAction.fileDropArea(action:)
            )
        ) {
            NavigationView {
                MasterView(
                    store: store.derived(
                        stateMapper: \.masterState,
                        actionMapper: WindowContentViewAction.master(action:)
                    )
                )
                DetailView(
                    store: store.derived(
                        stateMapper: \.detailState,
                        actionMapper: WindowContentViewAction.detail(action:)
                    )
                )
            }
            .toolbar {
                ToolbarItems(
                    store: store.derived(
                        stateMapper: \.toolbarState,
                        actionMapper: WindowContentViewAction.toolbar(action:)
                    )
                )
            }
        }
        .sheet(
            isPresented: store.binding(
                get: \.isOnboardingPresented,
                send: { isOnboardingPresented in .updateIsOnboardingCompleted(!isOnboardingPresented) }
            ),
            content: {
                OnboardingView(
                    store: store.derived(
                        stateMapper: \.onboardingState,
                        actionMapper: WindowContentViewAction.onboarding(action:)
                    )
                )
            }
        )
        .onAppear { store.send(.didAppear) }
        .onDisappear { store.send(.didDisappear) }
    }
}

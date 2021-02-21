//  Copyright © 2021 Andreas Link. All rights reserved.

import SwiftUI

struct OnboardingView: View {
    @ObservedObject var store: ViewStore<OnboardingViewState, OnboardingViewAction>

    var body: some View {
        VStack(spacing: 16) {
            VStack(spacing: 0) {
                Image("icon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 90, height: 90, alignment: .center)
                Spacer()
                    .frame(height: 16)
                Text(store.title)
                    .font(.largeTitle)
                Spacer()
                    .frame(height: 16)
                Text(store.subtitle)
                    .multilineTextAlignment(.center)
                Spacer()
                    .frame(height: 16)
                SupportedManifestsView(
                    store: store.derived(stateMapper: \.supportedManifestsState).withoutActions
                )
            }

            Spacer()

            Button(store.primaryButtonTitle) {
                store.send(.didTriggerPrimaryButton)
            }
            .buttonStyle(BrandedButtonStyle())
        }
        .padding(48)
        .frame(width: 500, height: 500, alignment: .center)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(store: .constant(state: PreviewData.Onboarding.state))
    }
}

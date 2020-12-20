//  Copyright © 2020 Andreas Link. All rights reserved.

import SwiftUI

struct OnboardingView: View {
    var onOnboardingCompleted: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            VStack(spacing: 0) {
                Image("icon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 90, height: 90, alignment: .center)
                Spacer()
                    .frame(height: 16)
                Text(L10n.Onboarding.title)
                    .font(.largeTitle)
                Spacer()
                    .frame(height: 16)
                Text(L10n.Onboarding.subtitle)
                    .multilineTextAlignment(.center)
                Spacer()
                    .frame(height: 16)
                Text(L10n.Onboarding.SupportedManifests.description)
                Spacer()
                    .frame(height: 16)
                VStack(alignment: .leading, spacing: 8) {
                    Label(L10n.Onboarding.SupportedManifests.SwiftPm.title, systemImage: "swift")
                    Label(L10n.Onboarding.SupportedManifests.Carthage.title, systemImage: "shippingbox")
                    Label(L10n.Onboarding.SupportedManifests.CocoaPods.title, systemImage: "c.circle")
                }
            }

            Spacer()

            Button(L10n.Onboarding.PrimaryButton.title) {
                onOnboardingCompleted()
            }
            .buttonStyle(BrandedButtonStyle())
        }
        .padding(48)
        .frame(width: 500, height: 500, alignment: .center)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView {}
    }
}

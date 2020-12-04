//  Copyright © 2020 Andreas Link. All rights reserved.

import SwiftUI

struct OnboardingView: View {
    var onOnboardingCompleted: () -> Void

    var body: some View {
        VStack {
            Text("Onboarding:")
            Button("Complete Onboarding") {
                onOnboardingCompleted()
            }
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView {}
    }
}

//  Copyright © 2021 Andreas Link. All rights reserved.

import Foundation

enum SupportedManifestsViewStateMapper {
    static func map(state: AppState) -> SupportedManifestsViewState {
        return .init(
            title: L10n.Onboarding.SupportedManifests.description,
            entries: [
                .init(description: L10n.Onboarding.SupportedManifests.SwiftPm.title, imageSystemName: "swift"),
                .init(description: L10n.Onboarding.SupportedManifests.Carthage.title, imageSystemName: "shippingbox"),
                .init(description: L10n.Onboarding.SupportedManifests.CocoaPods.title, imageSystemName: "c.circle")
            ]
        )
    }
}

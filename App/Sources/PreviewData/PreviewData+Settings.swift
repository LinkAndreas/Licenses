//  Copyright © 2021 Andreas Link. All rights reserved.

extension PreviewData {
    enum Settings {
        static let state: SettingsViewState = .init(
            checkBoxDescription: "Checkbox Description",
            isCheckBoxChecked: true,
            tokenText: "Token",
            tokenPlaceholder: "Token Placeholder",
            tokenDescription: "Token Desciption",
            generalTab: .init(title: "General", imageSystemName: "gear", tag: .general),
            tokenTab: .init(title: "Token", imageSystemName: "tag", tag: .token)
        )
    }
}

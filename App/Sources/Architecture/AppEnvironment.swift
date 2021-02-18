//  Copyright © 2021 Andreas Link. All rights reserved.

struct AppEnvironment {
    let settingsDataSource: SettingsSynchronousDataSource
    let cocoaPodsProcessor: RepositoryProcessor
    let licenseProcessor: RepositoryProcessor
    let csvRowFactory: CSVRowFactory
    let csvExporter: CSVExporter

    init(
        settingsDataSource: SettingsSynchronousDataSource = Defaults.shared,
        cocoaPodsProcessor: RepositoryProcessor = CocoaPodsRepositoryProcessor(),
        licenseProcessor: RepositoryProcessor = LicenseRepositoryProcessor(),
        csvRowFactory: CSVRowFactory = .init(),
        csvExporter: CSVExporter = DefaultCSVExporter()
    ) {
        self.settingsDataSource = settingsDataSource
        self.cocoaPodsProcessor = cocoaPodsProcessor
        self.licenseProcessor = licenseProcessor
        self.csvRowFactory = csvRowFactory
        self.csvExporter = csvExporter
    }
}

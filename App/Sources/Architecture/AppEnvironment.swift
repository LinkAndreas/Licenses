//  Copyright © 2021 Andreas Link. All rights reserved.

import Combine
import Foundation

protocol AppEnvironment {
    var settingsDataSource: SettingsSynchronousDataSource { get }
    var swiftPmDecodingStrategy: ManifestDecodingStrategy { get }
    var carthageDecodingStrategy: ManifestDecodingStrategy { get }
    var cocoaPodsDecodingStrategy: ManifestDecodingStrategy { get }
    var cocoaPodsProcessor: RepositoryProcessor { get }
    var licenseProcessor: RepositoryProcessor { get }
    var csvRowFactory: CSVRowFactory { get }
    var csvExporter: CSVExporter { get }

    func manifestPublisher(filePaths: [URL]) -> AnyPublisher<Manifest, Never>
}

struct DefaultEnvironment: AppEnvironment {
    let settingsDataSource: SettingsSynchronousDataSource
    let swiftPmDecodingStrategy: ManifestDecodingStrategy
    let carthageDecodingStrategy: ManifestDecodingStrategy
    let cocoaPodsDecodingStrategy: ManifestDecodingStrategy
    let cocoaPodsProcessor: RepositoryProcessor
    let licenseProcessor: RepositoryProcessor
    let csvRowFactory: CSVRowFactory
    let csvExporter: CSVExporter

    init(
        settingsDataSource: SettingsSynchronousDataSource = Defaults.shared,
        swiftPmDecodingStrategy: ManifestDecodingStrategy = SwiftPmManifestDecodingStrategy(),
        carthageDecodingStrategy: ManifestDecodingStrategy = CarthageManifestDecodingStrategy(),
        cocoaPodsDecodingStrategy: ManifestDecodingStrategy = CocoaPodsManifestDecodingStrategy(),
        cocoaPodsProcessor: RepositoryProcessor = CocoaPodsRepositoryProcessor(),
        licenseProcessor: RepositoryProcessor = LicenseRepositoryProcessor(),
        csvRowFactory: CSVRowFactory = .init(),
        csvExporter: CSVExporter = DefaultCSVExporter()
    ) {
        self.settingsDataSource = settingsDataSource
        self.swiftPmDecodingStrategy = swiftPmDecodingStrategy
        self.carthageDecodingStrategy = carthageDecodingStrategy
        self.cocoaPodsDecodingStrategy = cocoaPodsDecodingStrategy
        self.cocoaPodsProcessor = cocoaPodsProcessor
        self.licenseProcessor = licenseProcessor
        self.csvRowFactory = csvRowFactory
        self.csvExporter = csvExporter
    }

    func manifestPublisher(filePaths: [URL]) -> AnyPublisher<Manifest, Never> {
        return ManifestPublisher(filePaths: filePaths).eraseToAnyPublisher()
    }
}

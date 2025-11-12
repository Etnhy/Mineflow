//
//  AppEnvironment.swift
//  Mineflow
//
//  Created by evhn on 12.11.2025.
//


struct AppEnvironment {
    var haptics: HapticsClient
    let settings: SettingsRepository
    let coredata: CoreDataRepository
    let urlOpener: URLOpener
    let tracking: TrackingService
    
    static let env = AppEnvironment(
        haptics: HapticsClient.live,
        settings: SettingsRepository(),
        coredata: CoreDataRepository(),
        urlOpener: SRLOpenerImpl(),
        tracking: TrackingServiceImpl()
    )
}

//
//  MineflowApp.swift
//  Mineflow
//
//  Created by evhn on 30.10.2025.
//

import SwiftUI
import GoogleMobileAds

@main
struct MineflowApp: App {
    
    private static let environment = AppEnvironment.env
    
    private static let loadedState: AppState = {
        
        let loadedTheme = environment.settings.loadTheme()
        let loadHaptics = environment.settings.loadHapticPreference()
        return AppState(currentTheme: loadedTheme)
    }()
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                AppView(initialState: Self.loadedState, environment: Self.environment)
                    .onAppear {
                        MobileAds.shared.start()
                    }
                
            }
            .preferredColorScheme(.light)
        }
        
    }
}

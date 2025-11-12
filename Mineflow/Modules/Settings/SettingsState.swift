//
//  SettingsState.swift
//  Mineflow
//
//  Created by evhn on 06.11.2025.
//

import Foundation

struct SettingsState {
    var theme: GameTheme
    var hapticIsOn: Bool
    
    var appVersion: String {
        let vers = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        return "\(NSLocalizedString("Version", comment: "app version")) \(vers)"
    }

}

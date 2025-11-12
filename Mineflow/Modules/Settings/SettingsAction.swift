//
//  SettingsAction.swift
//  Mineflow
//
//  Created by evhn on 06.11.2025.
//

import Foundation

enum SettingsAction {

    case themeMenuTapped
    
    case hapticToggleChanged(isOn: Bool)
    
    case urlOpened(urlString: String)
}

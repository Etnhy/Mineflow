//
//  SettingsReducer.swift
//  Mineflow
//
//  Created by evhn on 06.11.2025.
//

import Foundation

func settingsReducer(state: inout SettingsState?, action: SettingsAction) {
    guard var newState = state else {
        return
    }
    switch action {
    case .themeMenuTapped: break
    case .hapticToggleChanged(isOn: let isOn):
        newState.hapticIsOn = isOn
    case .urlOpened(urlString: let urlString):
        break
    }
    
    
    state = newState
}

//
//  ThemeReducer.swift
//  Mineflow
//
//  Created by evhn on 06.11.2025.
//

import Foundation

func themeReducer(state: inout ThemeState?, action: ThemeAction) {
    guard var newState = state else {
        return
    }
    switch action {
    case .themeChanged(let gameTheme):
        
        newState.theme = gameTheme
        
    }
    
    
    state = newState
}

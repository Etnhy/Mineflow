//
//  AppAction.swift
//  Mineflow
//
//  Created by evhn on 30.10.2025.
//

import Foundation



enum AppAction {
    case game(GameAction)
    case settings(SettingsAction)
    case theme(ThemeAction)
    
    case navigateToGame(StartGameModel)//(rows: Int, cols: Int, totalMines: Int)
    case navigateToSettings
    
    case navigateToThemeView
    
    case dismissSheet
    case navigationPathChanged([NavigationRoute])
    
}

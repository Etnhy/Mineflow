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
    case statisticAction(StatisticAction)
    
    case navigateToGame(StartGameModel)
    case navigateToSettings
    
    case navigateToThemeView
    
    case navigateToStatisticsView
    
    case dismissSheet
    case navigationPathChanged([NavigationRoute])
    
}

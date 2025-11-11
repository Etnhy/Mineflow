//
//  AppState.swift
//  Mineflow
//
//  Created by evhn on 30.10.2025.
//

enum NavigationRoute: Hashable {
    case game
    case settings
    case theme
    case statistic
    
}

enum SheetRoute: Identifiable {
    case settings
    case userProfile

    var id: Self { self }
}


import Foundation

struct AppState {
    
    var gameFeature: GameState?
    
    var settingsState: SettingsState?
    
    var themeState: ThemeState?
    
    var statisticState: StatisticState?
    
    var navigationPath: [NavigationRoute] = []
    
    var presentedSheet: SheetRoute? = nil

    var currentTheme: GameTheme = .classic
}

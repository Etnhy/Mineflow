//
//  AppAction.swift
//  Mineflow
//
//  Created by evhn on 30.10.2025.
//

import SwiftUI



enum AppAction {
    
    case splash(SplashAction)
    case onboarding(OnboardingAction)
    case game(GameAction)
    case settings(SettingsAction)
    case theme(ThemeAction)
    case statisticAction(StatisticAction)
    case howToPlay(InfoPlayAction)
    
    case navigateToGame(StartGameModel)
    case navigateToSettings
    case navigateToThemeView
    case navigateToStatisticsView
    
    case presentInfoPlaySheet
    
    case dismissSheet
    case navigationPathChanged([NavigationRoute])
    case scenePhaseChanged(ScenePhase)
}

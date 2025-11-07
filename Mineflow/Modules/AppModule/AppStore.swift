//
//  AppStore.swift
//  Mineflow
//
//  Created by evhn on 30.10.2025.
//

import SwiftUI
import Combine

struct AppEnvironment {
    var haptics: HapticsClient
    
    static let env = AppEnvironment(haptics: HapticsClient.live)
}


@MainActor
final class AppStore: ObservableObject {
    
    @Published private(set) var state: AppState

    let environment: AppEnvironment
    
    init(state: AppState, env: AppEnvironment) {
        self.state = state
        self.environment = env
    }
    
    func send(_ action: AppAction) {
        let previousState = self.state
        
        var newState = self.state
        
        appReducer(state: &newState, action: action)

        self.state = newState

        handleEffects(action: action, state: &newState,previousState: previousState)
    }
    
    
    private func handleEffects(action: AppAction, state: inout AppState, previousState: AppState) {
        
        switch action {
        case .game(let gameAction):
            handleGameEffects(
                action: gameAction,
                state: state.gameFeature,
                previousState: previousState.gameFeature
            )
        case .settings(let settingsAction):
            handleSettingsEffect(action: settingsAction)
            
        case .theme(let themeAction):
            handleThmeEffects(action: themeAction)
        default: break
        }
    }
    
    private func appReducer(state: inout AppState, action: AppAction) {
        switch action {
        case .game(let gameAction):
            gameReducer(state: &state.gameFeature, action: gameAction)
            
        case .navigateToGame(let rows,let cols, let mines):
            let gameState = GameState(rows: rows, cols: cols, totalMines: mines)
            state.gameFeature = gameState
            state.navigationPath.append(.game)
            
        case .dismissSheet:
            state.presentedSheet = nil
            
        case .navigationPathChanged(let path):
            state.navigationPath = path
            
        case .navigateToSettings:
            let settingsState = SettingsState(theme: state.currentTheme)
            state.settingsState = settingsState
            
            state.navigationPath.append(.settings)
            
        case .settings(let settingsAction):
            settingsReducer(state: &state.settingsState, action: settingsAction)
        case .navigateToThemeView:
            let themeState = ThemeState(theme: state.currentTheme)
            state.themeState = themeState
            state.navigationPath.append(.theme)

        case .theme(let themeAction):
            themeReducer(state: &state.themeState, action: themeAction)
        }
        
    }
    
    
    
    
}

private extension AppStore {
    func handleThmeEffects(action: ThemeAction) {
        switch action {
        case .themeChanged(let theme):
            state.currentTheme = theme
            state.settingsState?.theme = theme
//            UserDefaults.standard.set(theme.id, forKey: "theme")
        }
    }
}

private extension AppStore {
    func handleSettingsEffect(action: SettingsAction) {
        switch action {
        case .themeMenuTapped:
            send(.navigateToThemeView)
        }
    }
}

 //MARK: - Handle Game Effects
private extension AppStore {
     func handleGameEffects(action: GameAction, state: GameState?, previousState: GameState?) {
        guard let newState = state, let previousState = previousState else { return }
            let haptics = self.environment.haptics
            if newState.status == .won && previousState.status != .won {
                haptics.notify(.success)
//                print(state?.moveHistory)
                return
            }
            
            if newState.status == .lost && previousState.status != .lost {
                haptics.notify(.error)
                return
            }
                        
            switch action {
            case .tapCell:
                let newOpened = newState.board.flatMap { $0 }.filter { $0.isOpened }.count
                let oldOpened = previousState.board.flatMap { $0 }.filter { $0.isOpened }.count
                
                if newOpened > oldOpened {
                    haptics.play(.light)
                }
            case .longPressCell:
                let newQuestionMarkCount = newState.board
                    .flatMap { $0 }
                    .filter { $0.flagState == .questionMarked }
                    .count
                
                let oldQuestionMarkCount = previousState.board
                    .flatMap { $0 }
                    .filter { $0.flagState == .questionMarked }
                    .count
                
                if newState.flagsUsed != previousState.flagsUsed || newQuestionMarkCount != oldQuestionMarkCount {
                    haptics.play(.medium)
                }
            case .restartGame:
                haptics.play(.medium)
                
            case .timerTick:
                break
            }
        }

}

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
    let settings: SettingsRepository
    let coredata: CoreDataRepository
    
    static let env = AppEnvironment(
        haptics: HapticsClient.live,
        settings: SettingsRepository(), coredata: CoreDataRepository()
    )
    
    
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
    
    
    
    
    private func appReducer(state: inout AppState, action: AppAction) {
        switch action {
        case .game(let gameAction):
            gameReducer(state: &state.gameFeature, action: gameAction)
            
        case .navigateToGame(let game):
            let gameState = GameState(gameModel: game)
            state.gameFeature = gameState
            state.navigationPath.append(.game)
            
        case .dismissSheet:
            state.presentedSheet = nil
            
        case .navigationPathChanged(let path):
            state.navigationPath = path
            
        case .navigateToSettings:
            let settingsState = SettingsState(
                theme: state.currentTheme,
                hapticIsOn: environment.settings.hapticIsOn
            )
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
        case .navigateToStatisticsView:
            let statisticState = StatisticState(theme: state.currentTheme)
            state.statisticState = statisticState
            state.navigationPath.append(.statistic)
        case .statisticAction(let statAction):
            statisticreducer(state: &state.statisticState, action: statAction)
        }
        
    }
    
    
    private func handleEffects(action: AppAction, state: inout AppState, previousState: AppState) {
        
        switch action {
        case .game(let gameAction):
            handleGameEffects(
                action: gameAction,
                appState: state,
                previousState: previousState.gameFeature
            )
        case .settings(let settingsAction):
            handleSettingsEffect(action: settingsAction)
            
        case .theme(let themeAction):
            handleThmeEffects(action: themeAction)
        case .statisticAction(let statAction):
            handleStatisticEffects(action: statAction)
        default: break
        }
    }
    
    
    
}
private extension AppStore {
    func handleStatisticEffects(action: StatisticAction) {
        switch action {
        case .viewAppeared:
            Task {
                do {
                    let loadedModels = try environment.coredata.fetchGameModels()
                    await MainActor.run {
                        self.send(.statisticAction(.statisticsLoaded(loadedModels)))
                    }
                } catch {
                    print("❗️ CoreData Fetch Error: \(error)")
                }
            }
        case .statisticsLoaded(_):
            break
        case .resetAllStatistics:
            Task {
                do {
                    try environment.coredata.deleteAllGameModels()
                    await MainActor.run {
                        self.send(.statisticAction(.statisticsLoaded([])))
                    }

                }catch {
                    print(error)
                }
            }
            
        }
    }
}

private extension AppStore {
    func handleThmeEffects(action: ThemeAction) {
        switch action {
        case .themeChanged(let theme):
            state.currentTheme = theme
            state.settingsState?.theme = theme
            environment.settings.saveTheme(theme)
        }
    }
}

 //MARK: - Handle settings efffects
private extension AppStore {
    func handleSettingsEffect(action: SettingsAction) {
        switch action {
        case .themeMenuTapped:
            send(.navigateToThemeView)
        case .hapticToggleChanged(isOn: let isOn):
            environment.settings.saveHapticPreference(isOn)
        }
    }
}

//MARK: - Handle Game Effects
private extension AppStore {
    func handleGameEffects(action: GameAction, appState: AppState, previousState: GameState?) {
        
        guard environment.settings.hapticIsOn else {
            return
        }
        
        guard let newState = state.gameFeature, let previousState = previousState else { return }
        
        let haptics = self.environment.haptics
        if newState.status == .won && previousState.status != .won {
            haptics.notify(.success)
            
            let gameModel = GameModel(
                date: Date(),
                status: newState.status,
                gameMode: newState.gameModel.gameMode,
                moveHistory: newState.moveHistory,
                time: newState.elapsedTime
            )
            do {
                try environment.coredata.saveGameModel(gameModel)
            } catch {
                print(error)
            }
            return
        }
        
        if newState.status == .lost && previousState.status != .lost {
            haptics.notify(.error)
            
            let gameModel = GameModel(
                date: Date(),
                status: newState.status,
                gameMode: newState.gameModel.gameMode,
                moveHistory: newState.moveHistory,
                time: newState.elapsedTime
            )
            do {
                try environment.coredata.saveGameModel(gameModel)
            } catch {
                print(error)
            }

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

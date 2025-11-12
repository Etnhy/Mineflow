//
//  AppStore.swift
//  Mineflow
//
//  Created by evhn on 30.10.2025.
//

import SwiftUI
import Combine


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
        case .scenePhaseChanged(let newPhase):
            if newPhase == .background {
                if let currentGameState = state.gameFeature, currentGameState.status == .playing {
                    environment.settings.saveInProgressGame(currentGameState)
                }
            }
        case .splash(let splashAction):
            splashReducer(state: &state.splashState, action: splashAction)
            
            if case .dataLoaded(let initialTheme, let inProgressGame,let hasCompletedOnboarding) = splashAction {
                state.currentTheme = initialTheme
                state.inProgressGame = inProgressGame
                
                if hasCompletedOnboarding {
                    send(.splash(.ended))
                } else {
                    state.onboardingState = OnboardingState()
                    send(.splash(.ended))
                }
            }
            
            
            
        case .onboarding(let onboardingAction):
            onboardingReducer(state: &state.onboardingState, action: onboardingAction)
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
        case .splash(let splashAction):
            handleSplashEffects(action: splashAction)
        case .onboarding(let onboardingAction):
            handleOnboardingEffects(action: onboardingAction, previousState: previousState)
        default: break
        }
    }
    
    
    
}

private extension AppStore {
    func handleOnboardingEffects(action: OnboardingAction,previousState: AppState) {
        switch action {
        case .next:
            guard let state = state.onboardingState else { return }
            if state.currentIndex > state.onboardingModels.count  {
                Task { @MainActor in
                    send(.onboarding(.completed))
                    
                }
            }
            
        case .completed:
            environment.settings.setOnboardingCompleted()

        }
    }
}


private extension AppStore {
    private func handleSplashEffects(action: SplashAction) {
        switch action {
        case .onAppear:
            Task {
                try await Task.sleep(for: .seconds(0.3))
                await environment.tracking.requestAuthorization()
                try await Task.sleep(for: .seconds(0.1))

                let initialTheme = environment.settings.loadTheme()
                let inProgressGame = environment.settings.fetchInProgressGame()
                
                await MainActor.run {
                    send(.splash(.dataLoaded(initialTheme, inProgressGame, environment.settings.getIsOnboardingCompleted())))
                }
            }
            
        case .dataLoaded:
            send(.splash(.ended))
            
        case .ended:
            break
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
                    LoggerInfo.log("fetch errot: \(error)")

                }
            }
        case .statisticsLoaded(_):
            break
        case .confirmDeleteAll:
            Task {
                do {
                    try environment.coredata.deleteAllGameModels()
                    await MainActor.run {
                        self.send(.statisticAction(.statisticsLoaded([])))
                    }

                } catch {
                    LoggerInfo.log(error)
                }
            }
            
        case .deleteAllButtonTapped:
            break
        case .dismissAlert:
            break
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
        case .urlOpened(urlString: let urlString):
            environment.urlOpener.open(urlString)
        }
    }
}

//MARK: - Handle Game Effects
private extension AppStore {
    func handleGameEffects(action: GameAction, appState: AppState, previousState: GameState?) {
        guard let newState = state.gameFeature, let previousState = previousState else { return }


        if newState.status == .won && previousState.status != .won || newState.status == .lost && previousState.status != .lost {
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
                LoggerInfo.log(error)

            }
        }
        
        guard environment.settings.hapticIsOn else {
            return
        }

        let haptics = self.environment.haptics
        
        if newState.status == .won && previousState.status != .won {
            haptics.notify(.success)
            

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

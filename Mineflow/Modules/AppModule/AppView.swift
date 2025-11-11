//
//  AppView.swift
//  Mineflow
//
//  Created by evhn on 30.10.2025.
//

import SwiftUI

struct AppView: View {
    
    @StateObject private var store: AppStore
    
    init(initialState: AppState, environment: AppEnvironment) {
        _store = StateObject(wrappedValue: AppStore(
            state: initialState,
            env: environment
        ))
    }
    
    var body: some View {
        
        let pathBinding = Binding(
            get: { store.state.navigationPath },
            set: { newPath in
                store.send(.navigationPathChanged(newPath))
            }
        )
        
        let sheetBinding = Binding(
            get: { store.state.presentedSheet },
            set: { newSheet in
                if newSheet == nil {
                    store.send(.dismissSheet)
                }
            }
        )
        let theme = store.state.currentTheme
        
        NavigationStack(path: pathBinding) {
            ZStack {
                BackgroundView(theme: theme)
                
                VStack {
                    
                    Text("MINEFLOW")
                        .font(.sofia(weight: .black900, size: 48))
                        .foregroundColor(theme.primaryTextColor)
                        .padding(.top, scaleHeight(120))
                    
                    Spacer()
                    
                    VStack(spacing: scaleHeight(15)) {
                        navigateButtons
                    }
                    .padding(.horizontal)
                    .padding(.bottom, scaleHeight(100))

                    Spacer()
                    
                    settingsButton
                        .padding(.bottom, scaleHeight(75))
                }
                .navigationDestination(for: NavigationRoute.self) { route in
                    switch route {
                    case .game:
                        if let game = store.state.gameFeature {
                            GameView(state: game, theme: store.state.currentTheme) { gameAction in
                                store.send(.game(gameAction))
                            }
                        }
                    case .settings:
                        if let settings = store.state.settingsState {
                            SettingsView(state: settings) { settingsAction in
                                store.send(.settings(settingsAction))
                            }
                        }
                    case .theme:
                        if let themeState = store.state.themeState {
                            ThemeView(state: themeState) { action in
                                store.send(.theme(action))
                            }
                        }
                    case .statistic:
                        if let statisticState = store.state.statisticState {
                            StatisticView(state: statisticState) { statisticAction in
                                store.send(.statisticAction(statisticAction))
                            }
                        }
                    }
                }
                .toolbar(.hidden, for: .navigationBar)

            }
        }
    }
    
    
    @ViewBuilder
    private var navigateButtons: some View {
        let theme = store.state.currentTheme
        
        VStack(spacing: scaleHeight(12)) {
            ForEach(StartGameModel.allCeses, id: \.id) { model in
                Button {
                    store.send(.navigateToGame(model))
                } label: {
                    PlayButtonView(theme: theme, model: model)
                }
            }
            
            Button {
                store.send(.navigateToStatisticsView)
            } label: {
                Text("Statistics")
            }

        }
    }
    
    @ViewBuilder
    private var settingsButton: some View {
        let theme = store.state.currentTheme
        
        HStack {
            Spacer()
            
            Button {
                store.send(.navigateToSettings)
            } label: {
                Image(systemName: "gear")
                    .font(.largeTitle)
                    .padding(15)
                    .background(theme.headerBackgroundColor)
                    .foregroundColor(theme.accentColor)
                    .clipShape(Circle())
                    .shadow(color: .black.opacity(0.2), radius: 5, y: 3)
            }
            .padding(.trailing, 20)
        }
    }
}

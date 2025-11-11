////
////  AppView.swift
////  Mineflow
////
////  Created by evhn on 30.10.2025.
////
//
//import SwiftUI
//
//struct AppView: View {
//    
//    @StateObject private var store: AppStore//(state: .init(), env: .env)
//    
//    init(initialState: AppState, environment: AppEnvironment) {
//            _store = StateObject(wrappedValue: AppStore(
//                state: initialState,
//                env: environment
//            ))
//        }
//    
//    var body: some View {
//        
//        let pathBinding = Binding(
//            get: { store.state.navigationPath },
//            set: { newPath in
//                store.send(.navigationPathChanged(newPath))
//            }
//        )
//        
//        let sheetBinding = Binding(
//            get: { store.state.presentedSheet },
//            set: { newSheet in
//                if newSheet == nil {
//                    store.send(.dismissSheet)
//                }
//            }
//        )
//        
//        let theme = store.state.currentTheme
//        
//        NavigationStack(path: pathBinding) {
//            ZStack(alignment: .top) {
//                BackgroundView(theme: theme)
//                
//                VStack {
//                    AppViewHeader(theme: store.state.currentTheme, title: "Minesweeper")
//                    VStack(spacing: scaleHeight(100)) {
//                        navigateButtons
//                            .padding(.top,scaleHeight(150))
//
//                        Button {
//                            store.send(.navigateToSettings)
//
//                        } label: {
//                            Text("Settings")
//                        }
//
//                    }
//                }
//                .navigationDestination(for: NavigationRoute.self) { route in
//                    switch route {
//                    case .game:
//                        if let game = store.state.gameFeature {
//                            GameView(state: game, theme: store.state.currentTheme) { gameAction in
//                                store.send(.game(gameAction))
//                            }
//                            
//                        }
//                    case .settings:
//                        if let settings = store.state.settingsState {
//                            SettingsView(state: settings) { settingsAction in
//                                store.send(.settings(settingsAction))
//                            }
//                        }
//                    case .theme:
//                        if let themeState = store.state.themeState {
//                            ThemeView(state: themeState) { action in
//                                store.send(.theme(action))
//                            }
//                            
//                        }
//                    }
//                }
//            }
//            
//        }
//        
//    }
//    
//    @ViewBuilder
//    private var navigateButtons: some View {
//        let theme = store.state.currentTheme
//        
//        VStack(spacing: scaleHeight(10)) {
//            ForEach(StartGameModel.allCeses, id: \.id) { model in
//                Button {
//                    store.send(.navigateToGame(model))
//                } label: {
//                    PlayButtonView(theme: store.state.currentTheme, model: model)
//                }
//
//            }
//            
//        }
//        .foregroundStyle(theme.accentColor)
//        .font(.sofia(weight: .semiBold600, size: 18))
//    }
//}
//
//#Preview {
//    AppView(
//        initialState: .init(),
//        environment: AppEnvironment(
//            haptics: .noop,
//            settings: .init()
//        )
//    )
//}

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
                        .padding(.bottom, scaleHeight(50))
                }
                .navigationDestination(for: NavigationRoute.self) { route in
                    // ... (ваш navigationDestination)
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
                    }
                }
                // ⭐️ 4. Скрываем стандартный NavigationBar, т.к. он пустой
                .toolbar(.hidden, for: .navigationBar)
            }
        }
    }
    
    // --- Вспомогательные ViewBuilder ---
    
    @ViewBuilder
    private var navigateButtons: some View {
        let theme = store.state.currentTheme
        
        VStack(spacing: scaleHeight(12)) {
            ForEach(StartGameModel.allCeses, id: \.id) { model in
                Button {
                    store.send(.navigateToGame(model))
                } label: {
                    // Используем шикарный PlayButtonView
                    PlayButtonView(theme: theme, model: model)
                }
            }
        }
        // Убираем здесь foregroundStyle, он должен быть в PlayButtonView
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

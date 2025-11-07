//
//  AppView.swift
//  Mineflow
//
//  Created by evhn on 30.10.2025.
//

import SwiftUI

struct AppView: View {
    
    @StateObject private var store = AppStore(state: .init(), env: .env)
    
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
                    navigateButtons
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
                    }
                }
                
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            store.send(.navigateToSettings)
                        } label: {
                            Image(systemName: "gear")
                                .foregroundStyle(.black)
                        }
                        
                    }
                }
            }
            
        }
        
    }
    
    @ViewBuilder
    private var navigateButtons: some View {
        let theme = store.state.currentTheme
        
        VStack {
            Button {
                store.send(.navigateToGame(rows: 9, cols: 9, totalMines: 9))
            } label: {
                Text("play 9x9 9 bomb")
            }
            Button {
                store.send(.navigateToGame(rows: 16, cols: 16, totalMines: 40))
            } label: {
                Text("play 16x16 40 bomb")
            }
            Button {
                store.send(.navigateToGame(rows: 32, cols: 16, totalMines: 99))
            } label: {
                Text("play, 32x16 99 bomb")
            }
            
        }
        .foregroundStyle(theme.accentColor)
        
    }
}

#Preview {
    AppView()
}

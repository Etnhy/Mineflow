//
//  StatisticView.swift
//  Mineflow
//
//  Created by evhn on 11.11.2025.
//

import SwiftUI

struct StatisticView: View {
    var state: StatisticState
    var send: (StatisticAction) -> Void
    
    private var alertBinding: Binding<StatisticAlert?> {
            Binding(
                get: { state.confirmationAlert },
                set: { newValue in
                    if newValue == nil {
                        send(.dismissAlert)
                    }
                }
            )
        }
    
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack(alignment: .top) {
            state.theme.backgroundColor.ignoresSafeArea()
            VStack {
                AppViewHeader(theme: state.theme, title: "Statistic") {
                    dismiss()
                }
                if state.isLoading {
                    ProgressView()
                        .tint(state.theme.accentColor)
                } else {
                    ScrollView {
                        
                        VStack {
                            StatisticModeView(
                                theme: state.theme,
                                mode: .easy,
                                allGames: state.easyGames.count,
                                wins: state.easyWins,
                                losses: state.easyLosses
                            )
                            
                            StatisticModeView(
                                theme: state.theme,
                                mode: .medium,
                                allGames: state.mediumGames.count,
                                wins: state.mediumWins,
                                losses: state.mediumLosses
                            )
                            
                            
                            StatisticModeView(
                                theme: state.theme,
                                mode: .hard,
                                allGames: state.hardGames.count,
                                wins: state.hardWins,
                                losses: state.hardLosses
                            )
                            
                            VStack(spacing: scaleHeight(15)) {
                                
                                if !state.games.isEmpty {
                                    
                                    Button {
                                        send(.deleteAllButtonTapped)
                                    } label: {
                                        SimpleTextButtonView(theme: state.theme, title: "Reset all statistics")
                                    }
                                    
                                    LazyVStack(alignment: .leading) {
                                        Text("All Games")
                                            .font(.sofia(weight: .bold700, size: 20))
                                            .foregroundStyle(state.theme.accentColor)
                                            .multilineTextAlignment(.leading)
                                        ForEach(state.games.reversed(), id: \.id) { gameModel in
                                            GameHistoryRowView(gameModel: gameModel, theme: state.theme)
                                        }
                                        
                                    }
                                    
                                } else {
                                    Text("You haven't played any games yet.")
                                        .font(.sofia(weight: .medium500, size: 16))
                                        .foregroundStyle(state.theme.accentColor)
                                }
                                
                            }
                            .padding(.top,scaleHeight(15))
                            
                            
                            
                        }
                        .padding(.horizontal)
                        
                    }
                }
                
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
        .onAppear {
            send(.viewAppeared)
        }
        
        .alert(item: alertBinding) { alert in
            switch alert {
            case .deleteAll:
                return Alert(
                    title: Text("Delete All History"),
                    message: Text("Are you sure you want to permanently delete all game statistics? This cannot be undone."),
                    primaryButton: .destructive(Text("Delete All")) {
                        send(.confirmDeleteAll)
                    },
                    secondaryButton: .cancel(Text("Cancel")) {
                        send(.dismissAlert)
                    }
                )
            }
        }
    
        
    }
}

#Preview {
    StatisticView(state: StatisticState(theme: .candy)) { action in
        LoggerInfo.log(action)

    }
}


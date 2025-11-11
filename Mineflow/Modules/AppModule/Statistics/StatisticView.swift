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
                            
                            Button {
                                send(.resetAllStatistics)
                            } label: {
                                Text("reset all")
                            }
                            
                            
                            
                            
                            LazyVStack(alignment: .leading) {
                                Text("All Games")
                                    .font(.sofia(weight: .bold700, size: 20))
                                    .foregroundStyle(state.theme.accentColor)
                                    .multilineTextAlignment(.leading)
                                    .padding(.leading)
                                ForEach(state.games.reversed(), id: \.id) { gameModel in
                                    GameHistoryRowView(gameModel: gameModel, theme: state.theme)
                                }
                                
                            }
                        }
                        
                    }
                }
                
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
        .onAppear {
            send(.viewAppeared)
        }
        
    }
}

#Preview {
    StatisticView(state: StatisticState(theme: .candy)) { action in
        print(action)
    }
}


//
//  StatisticReducer.swift
//  Mineflow
//
//  Created by evhn on 11.11.2025.
//


func statisticreducer(state: inout StatisticState?, action: StatisticAction) {
    
    guard var newState = state else {
        return
    }
    
    switch action {
    case .viewAppeared:
        newState.isLoading = true
    case .statisticsLoaded(let allGames):
        
        newState.games = allGames
        
        newState.easyGame.games = allGames.filter { $0.gameMode == .easy }
        newState.mediumGame.games = allGames.filter { $0.gameMode == .medium }
        newState.hardGame.games = allGames.filter { $0.gameMode == .hard }
        
        newState.isLoading = false
        
        
    case .deleteAllButtonTapped:
        newState.confirmationAlert = .deleteAll
    case .confirmDeleteAll:
        newState.confirmationAlert = nil
    case .dismissAlert:
        newState.confirmationAlert = nil
    }
    
    state = newState
}

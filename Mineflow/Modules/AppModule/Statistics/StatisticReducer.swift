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
        
        newState.easyGames = allGames.filter { $0.gameMode == .easy }
        newState.mediumGames = allGames.filter { $0.gameMode == .medium }
        newState.hardGames = allGames.filter { $0.gameMode == .hard }
        
        newState.easyWins = newState.easyGames.filter { $0.status == .won }.count
        newState.easyLosses = newState.easyGames.filter { $0.status == .lost }.count
        
        newState.mediumWins = newState.mediumGames.filter { $0.status == .won }.count
        newState.mediumLosses = newState.mediumGames.filter { $0.status == .lost }.count
        
        newState.hardWins = newState.hardGames.filter { $0.status == .won }.count
        newState.hardLosses = newState.hardGames.filter { $0.status == .lost }.count
        
        newState.isLoading = false
        
    case .resetAllStatistics:
        break
    }
    
    state = newState
}

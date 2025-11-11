//
//  StatisticState.swift
//  Mineflow
//
//  Created by evhn on 11.11.2025.
//

import SwiftUI



struct StatisticState {
    var isLoading: Bool = false
    var theme: GameTheme
    var games: [GameModel] = []
    
    var easyGames: [GameModel] = []
    var mediumGames: [GameModel] = []
    var hardGames: [GameModel] = []
    
    
    var easyWins: Int = 0
    var easyLosses: Int = 0
    
    var mediumWins: Int = 0
    var mediumLosses: Int = 0
    
    var hardWins: Int = 0
    var hardLosses: Int = 0
    
}







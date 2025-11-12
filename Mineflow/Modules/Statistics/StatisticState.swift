//
//  StatisticState.swift
//  Mineflow
//
//  Created by evhn on 11.11.2025.
//

import SwiftUI


struct StatisticGameModel {
    var games: [GameModel] = []
    
    let mode: GameMode
    
    var gamesCount: Int { games.count }
    var wins: Int { games.filter { $0.status == .won}.count }
    var loses: Int { games.filter { $0.status == .lost}.count }
    var bestTime: Double { games.map(\.time).min() ?? 0.0 }
}


struct StatisticState {
    var isLoading = false
    var confirmationAlert: StatisticAlert?
    
    var theme: GameTheme
    var games: [GameModel] = []
    
    var easyGame: StatisticGameModel = StatisticGameModel(mode: .easy)
    var mediumGame: StatisticGameModel = StatisticGameModel(mode: .medium)
    var hardGame: StatisticGameModel = StatisticGameModel(mode: .hard)
    

}

enum StatisticAlert: Identifiable {
    case deleteAll
    
    var id: String {
        switch self {
        case .deleteAll:
            return "deleteAll"
        }
    }
}





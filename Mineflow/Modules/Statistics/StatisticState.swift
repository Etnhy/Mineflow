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

#if DEBUG
extension StatisticGameModel {
    
    static let testEasy: StatisticGameModel = {
        var easy: [GameModel] = []
        
        for i in 0..<174 {
            let randomStatus = Bool.random()
            let randomtime = Double.random(in: 12...63.0)
            let model = GameModel(
                date: Date(),
                status: randomStatus ? .won : .lost,
                gameMode: .easy,
                moveHistory: [],
                time: randomtime
            )
            
            easy.append(model)
        }
        
        return StatisticGameModel(games: easy, mode: .easy)
    }()
    
    static let testmedium: StatisticGameModel = {
        var medium: [GameModel] = []
        
        for i in 0..<83 {
            let randomStatus = Bool.random()
            let randomtime = Double.random(in: 46...125)
            let model = GameModel(
                date: Date(),
                status: randomStatus ? .won : .lost,
                gameMode: .medium,
                moveHistory: [],
                time: randomtime
            )
            
            medium.append(model)
        }
        
        return StatisticGameModel(games: medium, mode: .medium)
    }()
    
    
    static let testhard: StatisticGameModel = {
        var hard: [GameModel] = []
        
        for i in 0..<41 {
            let randomStatus = Bool.random()
            let randomtime = Double.random(in: 90...500)
            let model = GameModel(
                date: Date(),
                status: randomStatus ? .won : .lost,
                gameMode: .hard,
                moveHistory: [],
                time: randomtime
            )
            
            hard.append(model)
        }
        
        return StatisticGameModel(games: hard, mode: .hard)
    }()
}

#endif


struct StatisticState {
    var isLoading = false
    var confirmationAlert: StatisticAlert?
    
    var theme: GameTheme
    var games: [GameModel] = []
    
    #if DEBUG
    var easyGame: StatisticGameModel = .testEasy
    var mediumGame: StatisticGameModel = .testmedium
    var hardGame: StatisticGameModel = .testhard

    #else
    
    var easyGame: StatisticGameModel = StatisticGameModel(mode: .easy)
    var mediumGame: StatisticGameModel = StatisticGameModel(mode: .medium)
    var hardGame: StatisticGameModel = StatisticGameModel(mode: .hard)
    #endif
    

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





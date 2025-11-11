//
//  GameAction.swift
//  Mineflow
//
//  Created by evhn on 30.10.2025.
//


enum LoggedAction: Equatable, Codable { 
    case tap(row: Int, col: Int)
    case longPress(row: Int, col: Int)
}


enum GameAction {
    case tapCell(row: Int, col: Int)
    case longPressCell(row: Int, col: Int)
    case restartGame(StartGameModel)
    case timerTick
    
}

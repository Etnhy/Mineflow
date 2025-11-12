//
//  InProgressGameData.swift
//  Mineflow
//
//  Created by evhn on 12.11.2025.
//


struct InProgressGameData: Codable {
    
    let board: [[Cell]]
    let gameModel: StartGameModel
    let status: GameStatus
    let elapsedTime: Double
    let flagsUsed: Int
    let moveHistory: [LoggedAction]
    
}
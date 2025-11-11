//
//  StartGameModel.swift
//  Mineflow
//
//  Created by evhn on 10.11.2025.
//

import Foundation

enum GameMode: Int, CaseIterable {
    case easy, medium, hard
    var title: String {
        switch self {
        case .easy: return "Easy"
        case .medium: return "Medium"
        case .hard: return "Hard"
        }
    }
}

struct StartGameModel: Equatable,Identifiable {
    var id: UUID = UUID()
    let gameMode: GameMode
    let rows: Int
    let cols: Int
    let totalMines: Int
    
    static let easy = StartGameModel(gameMode: .easy, rows: 9, cols: 9, totalMines: 10)
    static let medium = StartGameModel(gameMode: .medium, rows: 16, cols: 16, totalMines: 40)
    static let hard = StartGameModel(gameMode: .hard, rows: 30, cols: 16, totalMines: 99)
    
    static let allCeses: [StartGameModel] = [.easy, .medium, .hard]
}

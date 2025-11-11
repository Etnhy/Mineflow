//
//  StartGameModel.swift
//  Mineflow
//
//  Created by evhn on 10.11.2025.
//

import Foundation

struct StartGameModel: Equatable,Identifiable {
    var id: UUID = UUID()
    let name: String
    let rows: Int
    let cols: Int
    let totalMines: Int
    
    static let easy = StartGameModel(name: "Easy", rows: 9, cols: 9, totalMines: 10)
    static let medium = StartGameModel(name: "Medium", rows: 16, cols: 16, totalMines: 40)
    static let hard = StartGameModel(name: "Hard", rows: 30, cols: 16, totalMines: 99)
    
    static let allCeses: [StartGameModel] = [.easy, .medium, .hard]
}

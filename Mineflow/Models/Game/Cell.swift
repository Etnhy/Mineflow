//
//  Cell.swift
//  Mineflow
//
//  Created by evhn on 30.10.2025.
//

import Foundation


struct Cell: Identifiable, Equatable,Codable {
    var id = UUID() 
    let row: Int
    let col: Int
    
    let isMine: Bool
    let surroundingMines: Int
    
    var isOpened: Bool = false
    var flagState: FlagState = .none
}

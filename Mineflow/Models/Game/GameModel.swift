//
//  GameModel.swift
//  Mineflow
//
//  Created by evhn on 11.11.2025.
//
import CoreData


struct GameModel: Identifiable {
    var id: UUID = UUID()
    var date: Date
    var status: GameStatus
    var gameMode: GameMode
    var moveHistory: [LoggedAction]
    var time: Double
}




extension GameEntity {
    
    var status: GameStatus {
        get {
            return GameStatus(rawValue: Int(self.statusRawValue)) ?? .initial
        }
        set {
            self.statusRawValue = Int16(newValue.rawValue)
        }
    }
    
    var gameMode: GameMode {
        get {
            return GameMode(rawValue: Int(self.gameModeRawValue)) ?? .easy
        }
        set {
            self.gameModeRawValue = Int16(newValue.rawValue)
        }
    }
    
    var moveHistory: [LoggedAction] {
        get {
            guard let data = self.moveHistoryData else { return [] }
            do {
                return try JSONDecoder().decode([LoggedAction].self, from: data)
            } catch {
                LoggerInfo.log("decode error moveHistory: \(error)")

                return []
            }
        }
        set {
            do {
                self.moveHistoryData = try JSONEncoder().encode(newValue)
            } catch {
                LoggerInfo.log("code error moveHistory: \(error)")

                self.moveHistoryData = nil
            }
        }
    }
    
    func configure(with model: GameModel) {
        self.date = model.date
        self.time = model.time
        
        self.status = model.status
        self.gameMode = model.gameMode
        self.moveHistory = model.moveHistory
    }
    
    var toModel: GameModel {
        let safeDate = self.date ?? Date.distantPast
        
        return GameModel(
            date: safeDate,
            status: self.status,
            gameMode: self.gameMode,
            moveHistory: self.moveHistory,
            time: self.time
        )
    }
}

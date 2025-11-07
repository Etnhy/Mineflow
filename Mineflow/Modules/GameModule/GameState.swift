//
//  GameState.swift
//  Mineflow
//
//  Created by evhn on 30.10.2025.
//

import Foundation

struct GameModel {
    var date: Date
    var moveHistory: [LoggedAction]
    var time: Double
}


struct GameState: Equatable {
    var board: [[Cell]] = []
    let rows: Int
    let cols: Int
    let totalMines: Int
    
    var status: GameStatus
    var elapsedTime: Double
    
    var flagsUsed: Int
    var moveHistory: [LoggedAction] = []
    
    var nonMineCellsToOpen: Int {
        return (rows * cols) - totalMines - board.flatMap { $0 }.filter { $0.isOpened }.count
    }
    
    var isGameWon: Bool {
        return nonMineCellsToOpen == 0
    }
    
    init(rows: Int, cols: Int, totalMines: Int) {
        self.rows = rows
        self.cols = cols
        self.totalMines = totalMines
        self.status = .initial
        self.elapsedTime = 0.0
        self.flagsUsed = 0
        self.board = generateEmptyBoard(rows: rows, cols: cols)

    }
}

extension GameState {
   static let testState: GameState = {
        // 1. Создаем пустой 9x9 стейт
        var state = GameState(rows: 9, cols: 9, totalMines: 10)
        
        // 2. Вручную "рисуем" нашу тестовую доску
        
        // --- Ряд 0: Закрытые ячейки и цифры ---
        state.board[0][0] = Cell(row: 0, col: 0, isMine: false, surroundingMines: 1, isOpened: true)
        state.board[0][1] = Cell(row: 0, col: 1, isMine: false, surroundingMines: 1, isOpened: true)
        state.board[0][2] = Cell(row: 0, col: 2, isMine: false, surroundingMines: 1, isOpened: true)
        
        // --- Ряд 1: Цифра, пустая ячейка, цифра ---
        state.board[1][0] = Cell(row: 1, col: 0, isMine: false, surroundingMines: 1, isOpened: true)
        state.board[1][1] = Cell(row: 1, col: 1, isMine: false, surroundingMines: 0, isOpened: true) // < ОТКРЫТЫЙ НОЛЬ
        state.board[1][2] = Cell(row: 1, col: 2, isMine: false, surroundingMines: 1, isOpened: true)

        // --- Ряд 2: Цифра, пустая ячейка, цифра ---
        state.board[2][0] = Cell(row: 2, col: 0, isMine: false, surroundingMines: 1, isOpened: true)
        state.board[2][1] = Cell(row: 2, col: 1, isMine: false, surroundingMines: 0, isOpened: true) // < ОТКРЫТЫЙ НОЛЬ
        state.board[2][2] = Cell(row: 2, col: 2, isMine: false, surroundingMines: 1, isOpened: true)

        // --- Ряд 3: Цифры (граница "бухты") ---
        state.board[3][0] = Cell(row: 3, col: 0, isMine: false, surroundingMines: 2, isOpened: true)
        state.board[3][1] = Cell(row: 3, col: 1, isMine: false, surroundingMines: 2, isOpened: true)
        state.board[3][2] = Cell(row: 3, col: 2, isMine: false, surroundingMines: 2, isOpened: true)
        
        // --- Ряд 4: Демонстрация всех цифр подряд ---
        state.board[4][0] = Cell(row: 4, col: 0, isMine: false, surroundingMines: 1, isOpened: true)
        state.board[4][1] = Cell(row: 4, col: 1, isMine: false, surroundingMines: 2, isOpened: true)
        state.board[4][2] = Cell(row: 4, col: 2, isMine: false, surroundingMines: 3, isOpened: true)
        state.board[4][3] = Cell(row: 4, col: 3, isMine: false, surroundingMines: 4, isOpened: true)
        state.board[4][4] = Cell(row: 4, col: 4, isMine: false, surroundingMines: 5, isOpened: true)
        state.board[4][5] = Cell(row: 4, col: 5, isMine: false, surroundingMines: 6, isOpened: true)
        state.board[4][6] = Cell(row: 4, col: 6, isMine: false, surroundingMines: 7, isOpened: true)
        state.board[4][7] = Cell(row: 4, col: 7, isMine: false, surroundingMines: 8, isOpened: true)

        // --- Ряд 5: Демонстрация состояний ---
        state.board[5][0] = Cell(row: 5, col: 0, isMine: true, surroundingMines: 0, isOpened: true) // Взорванная бомба
        state.board[5][1] = Cell(row: 5, col: 1, isMine: true, surroundingMines: 0, isOpened: false, flagState: .flagged) // Флаг
        state.board[5][2] = Cell(row: 5, col: 2, isMine: false, surroundingMines: 0, isOpened: false, flagState: .questionMarked) // Вопрос
        // [5][3] - останется закрытой по умолчанию

        // --- 3. Настраиваем остальной стейт ---
        state.elapsedTime = 123
        state.flagsUsed = 1
        state.status = .playing // Показываем поле, а не оверлей
        
        return state
    }()
}

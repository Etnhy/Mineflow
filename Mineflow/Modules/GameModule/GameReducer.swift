//
//  GameReducer.swift
//  Mineflow
//
//  Created by evhn on 30.10.2025.
//

private struct Coordinate: Hashable {
    let r: Int
    let c: Int
}


func gameReducer(state: inout GameState?, action: GameAction) -> Void {
    guard var newState = state else { return }
    switch action {
        
    case .restartGame(let game):
        newState = GameState(gameModel: game)
        
    case .timerTick:
        guard newState.status == .playing else { return }
        newState.elapsedTime += 1
        
    case .tapCell(let r, let c):
        
        guard newState.status != .lost else { return }
        
        if newState.status == .initial {
            newState.board = generateBoard(
                rows: newState.gameModel.rows,
                cols: newState.gameModel.cols,
                mines: newState.gameModel.totalMines,
                safeStart: (r: r, c: c)
            )
            newState.status = .playing
        }
        
        let cell = newState.board[r][c]

        if cell.isOpened && cell.surroundingMines > 0 {
            
            let neighbors = getNeighbors(r: r, c: c, rows: newState.gameModel.rows, cols: newState.gameModel.cols)
            let flaggedNeighbors = neighbors.filter { newState.board[$0.r][$0.c].flagState == .flagged }.count
            
            
            if flaggedNeighbors == cell.surroundingMines {
                
                var didHitMine = false
                var mineCoords: (r: Int, c: Int)? = nil
                var cellsToOpen: [(r: Int, c: Int)] = []
                
                
                for neighborCoords in neighbors {
                    let neighborCell = newState.board[neighborCoords.r][neighborCoords.c]
                    
                    
                    if neighborCell.flagState == .none && !neighborCell.isOpened {
                        if neighborCell.isMine {
                            
                            didHitMine = true
                            mineCoords = (r: neighborCoords.r, c: neighborCoords.c)
                            break
                        } else {
                            
                            cellsToOpen.append(neighborCoords)
                        }
                    }
                }
                
                
                if didHitMine {
                    newState.status = .lost
                    newState.board[mineCoords!.r][mineCoords!.c].isOpened = true
                } else {
                    
                    for cellToOpen in cellsToOpen {
                        
                        openCell(&newState, r: cellToOpen.r, c: cellToOpen.c)
                    }
                }
                
                
                if newState.isGameWon {
                    newState.status = .won
                    for r_idx in 0..<newState.gameModel.rows {
                        for c_idx in 0..<newState.gameModel.cols {
                             
                             let currentCell = newState.board[r_idx][c_idx]
                             
                             if currentCell.isMine {
                                 newState.board[r_idx][c_idx].isOpened = true
                             }
                             
                             //FIXME: strike flag
                             if !currentCell.isMine && currentCell.flagState == .flagged {
                                 
                             }
                         }
                     }
                }
                
                newState.moveHistory.append(.tap(row: r, col: c))
                state = newState
                return
            }
        }
        
        guard cell.flagState == .none && !cell.isOpened else { return }
        
        
        if cell.isMine {
            newState.status = .lost
            newState.board[r][c].isOpened = true
            
            for r_idx in 0..<newState.gameModel.rows {
                for c_idx in 0..<newState.gameModel.cols {
                     
                     let currentCell = newState.board[r_idx][c_idx]
                     
                     if currentCell.isMine {
                         newState.board[r_idx][c_idx].isOpened = true
                     }
                     
                     //FIXME: strike flag
                     if !currentCell.isMine && currentCell.flagState == .flagged {
                         
                     }
                 }
             }
            
            state = newState
            return
        }
        
        
        openCell(&newState, r: r, c: c)
        
        
        if newState.isGameWon {
            newState.status = .won
            for r_idx in 0..<newState.gameModel.rows {
                for c_idx in 0..<newState.gameModel.cols {
                     
                     let currentCell = newState.board[r_idx][c_idx]
                     
                     if currentCell.isMine {
                         newState.board[r_idx][c_idx].flagState = .flagged
                     }
                     
//                     //FIXME: strike flag
//                     if !currentCell.isMine && currentCell.flagState == .flagged {
//                         
//                     }
                 }
             }
        }
        
        newState.moveHistory.append(.tap(row: r, col: c))
        
    case .longPressCell(let r, let c):
        guard newState.status == .playing else { return }
        guard !newState.board[r][c].isOpened else { return }
        
        switch newState.board[r][c].flagState {
        case .none:
            newState.board[r][c].flagState = .flagged
            newState.flagsUsed += 1
        case .flagged:
            newState.board[r][c].flagState = .questionMarked
            newState.flagsUsed -= 1
        case .questionMarked:
            newState.board[r][c].flagState = .none
        }
        newState.moveHistory.append(.longPress(row: r, col: c))

    case .howToPlayTapped:
        break
    }
    
    state = newState
}





private func getNeighbors(r: Int, c: Int, rows: Int, cols: Int) -> [(r: Int, c: Int)] {
    var neighbors: [(r: Int, c: Int)] = []
    for dr in -1...1 {
        for dc in -1...1 {
            if dr == 0 && dc == 0 { continue }
            let nr = r + dr
            let nc = c + dc
            
            if nr >= 0 && nr < rows && nc >= 0 && nc < cols {
                neighbors.append((r: nr, c: nc))
            }
        }
    }
    return neighbors
}

func generateBoard(rows: Int, cols: Int, mines: Int, safeStart: (r: Int, c: Int)) -> [[Cell]] {
    
    
    var safeZone = Set<Coordinate>()
    safeZone.insert(Coordinate(r: safeStart.r, c: safeStart.c))
    
    let neighborsOfSafeStart = getNeighbors(r: safeStart.r, c: safeStart.c, rows: rows, cols: cols)
    for neighbor in neighborsOfSafeStart {
        safeZone.insert(Coordinate(r: neighbor.r, c: neighbor.c))
    }
    
    
    var allPossibleCoordinates: [Coordinate] = []
    for r in 0..<rows {
        for c in 0..<cols {
            allPossibleCoordinates.append(Coordinate(r: r, c: c))
        }
    }
    
    let validMinePositions = allPossibleCoordinates.filter { !safeZone.contains($0) }
    
    let mineCoordinates = Set(validMinePositions.shuffled().prefix(mines))
    
    var board: [[Cell]] = []
    
    for r in 0..<rows {
        var rowArray: [Cell] = []
        for c in 0..<cols {
            
            let isMine = mineCoordinates.contains(Coordinate(r: r, c: c))
            var surroundingMines = 0
            
            if !isMine {
                let neighbors = getNeighbors(r: r, c: c, rows: rows, cols: cols)
                for neighbor in neighbors {
                    if mineCoordinates.contains(Coordinate(r: neighbor.r, c: neighbor.c)) {
                        surroundingMines += 1
                    }
                }
            }
            
            let cell = Cell(
                row: r,
                col: c,
                isMine: isMine,
                surroundingMines: surroundingMines,
                isOpened: false,
                flagState: .none
            )
            rowArray.append(cell)
        }
        board.append(rowArray)
    }
    
    return board
}

// MARK: - logic utils

func generateEmptyBoard(rows: Int, cols: Int) -> [[Cell]] {
    var newBoard: [[Cell]] = []
    for r in 0..<rows {
        var rowArray: [Cell] = []
        for c in 0..<cols {
            rowArray.append(Cell(row: r, col: c, isMine: false, surroundingMines: 0))
        }
        newBoard.append(rowArray)
    }
    return newBoard
}


private func openCell(_ state: inout GameState, r: Int, c: Int) {
    guard r >= 0 && r < state.gameModel.rows && c >= 0 && c < state.gameModel.cols else { return }
    let cell = state.board[r][c]
    if cell.isOpened || cell.isMine || cell.flagState != .none {
        return
    }
    
    state.board[r][c].isOpened = true
    
    if cell.surroundingMines == 0 {
        let neighbors = getNeighbors(r: r, c: c, rows: state.gameModel.rows, cols: state.gameModel.cols)
        for neighbor in neighbors {
            openCell(&state, r: neighbor.r, c: neighbor.c)
        }
    }
}

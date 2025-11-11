
//
//  GameView.swift
//  Mineflow
//
//  Created by evhn on 30.10.2025.
//


import SwiftUI
import Combine

struct GameView: View {
    
    var state: GameState
    var theme: GameTheme
    
    let send: (GameAction) -> Void
    
    @GestureState private var gestureOffset: CGSize = .zero
    @GestureState private var gestureScale: CGFloat = 1.0
    
    @State private var finalScale: CGFloat = 1
    @State private var finalOffset: CGSize = .zero
    
    private let padding: CGFloat = 2.0
    private let cellSpacing: CGFloat = 1.0
    
    @Environment(\.dismiss) var dismiss
    
    
    @State var timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            theme.backgroundColor.ignoresSafeArea()
            VStack(spacing: 0) {
                AppViewHeader(theme: theme, title: state.gameModel.gameMode.title) {
                    dismiss()
                }
                GameHeaderView(theme: theme,
                               status: state.status,
                               elapsedTime: state.elapsedTime,
                               flagsRemaining: state.gameModel.totalMines - state.flagsUsed,
                               onRestart: restartAction
                )
                
                gameField()
            }
            .edgesIgnoringSafeArea(.bottom)
            .onReceive(timer) { _ in
                send(.timerTick)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
        
    }
    
    
    private func gameField() -> some View {
        GeometryReader { geometry in
            
            let _ = calculateCellSize(geometry: geometry)
            let finalRadius = cellCornerRadius()
            let finalFontSize = cellFontSize()
            let finalImageSize = cellImageSize()
            
            let boardView = BoardGridView(
                board: state.board,
                rows: state.gameModel.rows,
                cols: state.gameModel.cols,
                theme: theme,
                cellSpacing: cellSpacing,
                padding: padding,
                finalRadius: finalRadius,
                finalFontSize: finalFontSize,
                finalImageSize: finalImageSize,
                send: send
            )
            
            ZStack(alignment: .center) {
                theme.backgroundColor.ignoresSafeArea()
                boardView
                    .scaleEffect(finalScale * gestureScale, anchor: .center)
                    .offset(x: finalOffset.width + gestureOffset.width, y: finalOffset.height + gestureOffset.height)
            }
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
            .clipped()
            .contentShape(Rectangle())
            
            .onTapGesture { location in
                if let (row, col) = convertTapLocationToCell(location: location, geometry: geometry) {
                    send(.tapCell(row: row, col: col))
                }
            }
            .simultaneousGesture(
                DragGesture(minimumDistance: 10)
                    .updating($gestureOffset) { value, state, _ in
                        state = value.translation
                    }
                    .onEnded { value in
                        finalOffset.width += value.translation.width
                        finalOffset.height += value.translation.height
                    }
            )
            .simultaneousGesture(
                MagnificationGesture()
                    .updating($gestureScale) { value, state, _ in
                        state = value
                    }
                    .onEnded { value in
                        finalScale *= value
                        finalScale = max(0.5, min(finalScale, 5.0))
                    }
            )
        }
        
    }
    
//    private func gameField() -> some View {
//        GeometryReader { geometry in
//            let _ = calculateCellSize(geometry: geometry)
//            
//            let finalRadius = cellCornerRadius()
//            let finalFontSize = cellFontSize()
//            let finalImageSize = cellImageSize()
//            
//            let boardView = Grid(horizontalSpacing: cellSpacing, verticalSpacing: cellSpacing) {
//                ForEach(0..<state.gameModel.rows, id: \.self) { row in
//                    GridRow {
//                        ForEach(0..<state.gameModel.cols, id: \.self) { col in
//                            let cell = state.board[row][col]
//                            
//                            CellView(
//                                theme: theme,
//                                cell: cell,
//                                cellCornerRadius: finalRadius,
//                                cellFontSize: finalFontSize,
//                                cellImageSize: finalImageSize
//                            )
//                            .onLongPressGesture(minimumDuration: 0.3) {
//                                send(.longPressCell(row: row, col: col))
//                            }
//                        }
//                    }
//                }
//            }
//                .padding(padding)
//                .background(Color.gray.opacity(0.5))
//                .drawingGroup()
//            ZStack(alignment: .center) {
//                theme.backgroundColor.ignoresSafeArea()
//                boardView
//                    .scaleEffect(finalScale * gestureScale, anchor: .center)
//                    .offset(x: finalOffset.width + gestureOffset.width, y: finalOffset.height + gestureOffset.height)
//            }
//            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
//            .clipped()
//            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
//            .clipped()
//            .contentShape(Rectangle())
//            
//            .onTapGesture { location in
//                if let (row, col) = convertTapLocationToCell(location: location, geometry: geometry) {
//                    send(.tapCell(row: row, col: col))
//                }
//            }
//            
//            .simultaneousGesture(
//                DragGesture(minimumDistance: 10)
//                    .updating($gestureOffset) { value, state, _ in
//                        state = value.translation
//                    }
//                    .onEnded { value in
//                        finalOffset.width += value.translation.width
//                        finalOffset.height += value.translation.height
//                    }
//            )
//            .simultaneousGesture(
//                MagnificationGesture()
//                    .updating($gestureScale) { value, state, _ in
//                        state = value
//                    }
//                    .onEnded { value in
//                        finalScale *= value
//                        finalScale = max(0.5, min(finalScale, 5.0))
//                    }
//            )
//        }
//        
//    }
    
    private func cellCornerRadius() -> CGFloat {
        switch state.gameModel.gameMode {
        case .easy:
            return theme.cornerRadius
        case .medium:
            return theme.cornerRadius / 2.0
        case .hard:
            return theme.cornerRadius / 4.0
        }
    }
    
    private func cellFontSize() -> CGFloat {
        switch state.gameModel.gameMode {
        case .easy:
            return 22
        case .medium:
            return 18
        case .hard:
            return 14
        }
    }
    
    private func cellImageSize() -> CGFloat {
        switch state.gameModel.gameMode {
        case .easy:
            return 35
        case .medium:
            return 20
        case .hard:
            return 15
            
        }
    }
    
    private func restartAction() {
        send(.restartGame(state.gameModel))
        withAnimation {
            finalScale = 1.0
            finalOffset = .zero
        }
    }
    
    private func calculateCellSize(geometry: GeometryProxy) -> CGFloat {
        let g = geometry.size
        let rows = CGFloat(state.gameModel.rows)
        let cols = CGFloat(state.gameModel.cols)
        
        let totalHorizontalSpace = (cols - 1) * cellSpacing + padding * 2
        let totalVerticalSpace = (rows - 1) * cellSpacing + padding * 2
        
        let cellWidth = (g.width - totalHorizontalSpace) / cols
        let cellHeight = (g.height - totalVerticalSpace) / rows
        
        return min(cellWidth, cellHeight)
    }
    
    private func convertTapLocationToCell(location: CGPoint, geometry: GeometryProxy) -> (row: Int, col: Int)? {
        
        let g = geometry.size
        
        let gCenter = CGPoint(x: g.width / 2, y: g.height / 2)
        
        let cellSize = calculateCellSize(geometry: geometry)
        let rows = CGFloat(state.gameModel.rows)
        let cols = CGFloat(state.gameModel.cols)
        
        let boardModelWidth = (cellSize * cols) + (cellSpacing * (cols - 1)) + (padding * 2)
        let boardModelHeight = (cellSize * rows) + (cellSpacing * (rows - 1)) + (padding * 2)
        let boardModelCenter = CGPoint(x: boardModelWidth / 2, y: boardModelHeight / 2)
        
        
        let tapRelativeToScreenCenter = CGPoint(
            x: location.x - gCenter.x,
            y: location.y - gCenter.y
        )
        
        let tapRelativeToScaledBoardCenter = CGPoint(
            x: tapRelativeToScreenCenter.x - finalOffset.width,
            y: tapRelativeToScreenCenter.y - finalOffset.height
        )
        
        let tapRelativeToBoardModelCenter = CGPoint(
            x: tapRelativeToScaledBoardCenter.x / (finalScale * gestureScale),
            y: tapRelativeToScaledBoardCenter.y / (finalScale * gestureScale)
        )
        
        let tapRelativeToBoardModelTopLeft = CGPoint(
            x: tapRelativeToBoardModelCenter.x + boardModelCenter.x,
            y: tapRelativeToBoardModelCenter.y + boardModelCenter.y
        )
        
        
        let tapInCells = CGPoint(
            x: tapRelativeToBoardModelTopLeft.x - padding,
            y: tapRelativeToBoardModelTopLeft.y - padding
        )
        
        
        let col = Int(floor(tapInCells.x / (cellSize + cellSpacing)))
        let row = Int(floor(tapInCells.y / (cellSize + cellSpacing)))
        
        
        guard row >= 0 && row < state.gameModel.rows && col >= 0 && col < state.gameModel.cols else {
            return nil
        }
        
        let xInCell = tapInCells.x.truncatingRemainder(dividingBy: cellSize + cellSpacing)
        let yInCell = tapInCells.y.truncatingRemainder(dividingBy: cellSize + cellSpacing)
        
        guard xInCell <= cellSize && yInCell <= cellSize else {
            return nil
        }
        
        return (row, col)
    }
}


#Preview {
    
    let testState = GameState.testState
    
    GameView(state: testState, theme: .classic, send: { action in
        print("Action sent: \(action)")
    })
}

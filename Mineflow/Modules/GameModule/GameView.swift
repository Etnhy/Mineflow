
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
    
    
    
    @State private var finalScale: CGFloat = 1.0
    @GestureState private var gestureScale: CGFloat = 1.0
    
    @State private var finalOffset: CGSize = .zero
    @GestureState private var gestureOffset: CGSize = .zero
    private let padding: CGFloat = 2.0
    private let cellSpacing: CGFloat = 1.0
    

  @State var timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            theme.backgroundColor.ignoresSafeArea()
            VStack(spacing: 0) {
                GameHeaderView(theme: theme,
                    status: state.status,
                    elapsedTime: state.elapsedTime,
                    flagsRemaining: state.totalMines - state.flagsUsed,
                    onRestart: restartAction
                )
                
                gameField()
//                    .overlay(
//                        Group {
//                            if state.status == .won || state.status == .lost {
//                                GameStatusOverlay(status: state.status, onRestart: restartAction)
//                            }
//                            
//                        }
//                    )
                
            }
            .edgesIgnoringSafeArea(.bottom)
            .onReceive(timer) { _ in
                send(.timerTick)
            }
        }
    }
    
    private func gameField() -> some View {
        GeometryReader { geometry in
            let boardView = Grid(horizontalSpacing: cellSpacing, verticalSpacing: cellSpacing) {
                ForEach(0..<state.rows, id: \.self) { row in
                    GridRow {
                        ForEach(0..<state.cols, id: \.self) { col in
                            let cell = state.board[row][col]
                            
                            CellView(theme: theme,cell: cell)
                                .onLongPressGesture(minimumDuration: 0.3) {
                                    send(.longPressCell(row: row, col: col))
                                }
                        }
                    }
                }
            }
                .padding(padding)
                .background(Color.gray.opacity(0.5))
            ZStack(alignment: .center) {
                boardView
                    .scaleEffect(finalScale * gestureScale, anchor: .center)
                    .offset(x: finalOffset.width + gestureOffset.width, y: finalOffset.height + gestureOffset.height)
            }
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
            .clipped()
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
                        finalScale = max(1.0, min(finalScale, 5.0))
                    }
            )
        }

    }
    
    private func restartAction() {
        send(.restartGame(rows: state.rows, cols: state.cols, mines: state.totalMines))
        withAnimation {
            finalScale = 1.0
            finalOffset = .zero
        }
    }
    
    private func calculateCellSize(geometry: GeometryProxy) -> CGFloat {
        let g = geometry.size
        let rows = CGFloat(state.rows)
        let cols = CGFloat(state.cols)
        
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
        let rows = CGFloat(state.rows)
        let cols = CGFloat(state.cols)
        
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
        
        
        guard row >= 0 && row < state.rows && col >= 0 && col < state.cols else {
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


struct GameHeaderView: View {
    let theme: GameTheme
    let status: GameStatus
    let elapsedTime: Double
    let flagsRemaining: Int
    let onRestart: () -> Void
    
    var body: some View {
        HStack {
            Text("🚩 \(flagsRemaining)")
                .font(.system(.title, design: .monospaced).bold())
            
            Spacer()
            
            Button(action: onRestart) {
                Text(smileyForStatus(status))
                    .font(.largeTitle)
            }
            
            Spacer()
            
            Text(String(format: "%.0f", elapsedTime))
                .font(.system(.title, design: .monospaced).bold())
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .background(theme.headerBackgroundColor)
    }
    
    private func smileyForStatus(_ status: GameStatus) -> String {
        switch status {
        case .initial, .playing: return "🙂"
        case .won: return "😎"
        case .lost: return "😵"
        }
    }
}

struct CellView: View {
    var theme: GameTheme
    let cell: Cell

    var cellIsOpenMine: Bool {
        cell.isOpened && cell.isMine
    }
    
    
    var body: some View {
        ZStack {
            let baseColor = cell.isOpened ? theme.cellOpened : theme.cellClosed
            
            ZStack {
                RoundedRectangle(cornerRadius: theme.cornerRadius)
                    .fill(cellIsOpenMine ? .red : baseColor)
                    .aspectRatio(1, contentMode: .fit)
                RoundedRectangle(cornerRadius: theme.cornerRadius)
                    .stroke(Color.black.opacity(0.3), lineWidth: 0.5)
                    .aspectRatio(1, contentMode: .fit)
                
            }
            

            if cell.isOpened {
                if cell.isMine {
                    TextOrIcon(theme.bombIcon)
                } else if cell.surroundingMines > 0 {
                    Text("\(cell.surroundingMines)")
                        .bold()
                        .font(.callout)
                    
                        .foregroundColor(theme.numberColors[cell.surroundingMines - 1])
                } else {
                    EmptyView()
                }
            } else {
                switch cell.flagState {
                case .flagged:
                    TextOrIcon(theme.flagIcon)
                    
                case .questionMarked:
                    TextOrIcon(theme.questionMarkIcon)
                case .none:
                    EmptyView()
                }
            }
        }
    }
    
    private func colorForNumber(_ number: Int) -> Color {
        switch number {
        case 1: return .blue
        case 2: return .green
        case 3: return .red
        case 4: return .purple
        case 5: return .orange
        case 6: return .cyan
        case 7: return .pink
        case 8: return .black
        default: return .black
        }
    }
    
    @ViewBuilder
        private func TextOrIcon(_ iconName: String) -> some View {

            if iconName.count == 1 {
                Text(iconName)
                    .font(.caption)
            } else {
                Image(systemName: iconName)
                    .font(.caption)
            }
        }
    
}

// MARK: - 4. Оверлей Статуса Игры
struct GameStatusOverlay: View {
    let status: GameStatus
    let onRestart: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Text(status == .won ? "Победа! 😎" : "Поражение 😵")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.white)
            
            Button("Играть снова", action: onRestart)
                .font(.title2)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.75))
    }
}



#Preview {

    let testState = GameState.testState
    
    GameView(state: testState, theme: .classic, send: { action in
        print("Action sent: \(action)")
    })
}

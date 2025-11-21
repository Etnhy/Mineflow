
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
    
    @Environment(\.dismiss) var dismiss
        
    @GestureState private var gestureOffset: CGSize = .zero
    @GestureState private var gestureScale: CGFloat = 1.0
    
    @State private var finalScale: CGFloat = 1.0
    @State private var finalOffset: CGSize = .zero
        
    private let padding: CGFloat = 2.0
    private let cellSpacing: CGFloat = 1.0
    private let constantCellSize: CGFloat = 40.0
        
    @State var timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    @State private var lastScreenSize: CGSize = .zero
    var body: some View {
        ZStack {
            theme.backgroundColor.ignoresSafeArea()
            VStack(spacing: 0) {
                let right = RightActionModel(icon: "questionmark.circle", action: {
                    send(.howToPlayTapped)
                })
                AppViewHeader(
                    theme: theme,
                    title: state.gameModel.gameMode.title,
                    onBack: {
                        dismiss()
                    },
                    rightAction: right)
                
                GameHeaderView(
                    theme: theme,
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
        .overlay(alignment: .top) {
            if state.status == .won || state.status == .lost {
                Button {
                    restartAction()
                } label: {
                    Text("Restart")
                        .font(.sofia(weight: .bold700, size: 18))
                        .foregroundStyle(theme.accentColor)
                        .padding()
                        .background(theme.headerBackgroundColor)
                        .clipShape(.capsule)
                }
                .padding(.top,scaleHeight(120))
            }

        }
    }
    
    
    private func gameField() -> some View {
        GeometryReader { geometry in
            
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
                cellSize: constantCellSize,
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
                if let (row, col) = convertTapLocationToCell(location: location, geometrySize: geometry.size) {
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
                        finalScale = max(0.5, min(finalScale, 2))
                    }
            )
            .onAppear {
                setInitialZoom(screenSize: geometry.size)
            }
            .onChange(of: state.gameModel) { _ in
                 setInitialZoom(screenSize: geometry.size)
            }
        }
    }
    
    
    private func getFullBoardSize() -> CGSize {
        let cols = CGFloat(state.gameModel.cols)
        let rows = CGFloat(state.gameModel.rows)
        
        let width = (cols * constantCellSize) + (max(0, cols - 1) * cellSpacing) + (padding * 2)
        let height = (rows * constantCellSize) + (max(0, rows - 1) * cellSpacing) + (padding * 2)
        
        return CGSize(width: width, height: height)
    }
    
    private func setInitialZoom(screenSize: CGSize) {
        lastScreenSize = screenSize
        let boardSize = getFullBoardSize()
        
        let scaleX = screenSize.width / boardSize.width
        let scaleY = screenSize.height / boardSize.height
        let newScale = min(scaleX, scaleY)
        
        withAnimation {
            self.finalScale = newScale - 0.05
            self.finalOffset = .zero
        }
    }
    
    private func restartAction() {
        send(.restartGame(state.gameModel))
        setInitialZoom(screenSize: lastScreenSize)
    }

    
    private func cellCornerRadius() -> CGFloat {
        theme.cornerRadius
    }
    
    private func cellFontSize() -> CGFloat {
        isSmallDevice ? 18 : 22
    }
    
    private func cellImageSize() -> CGFloat {
        35
    }


    private func convertTapLocationToCell(location: CGPoint, geometrySize: CGSize) -> (row: Int, col: Int)? {
            
            let boardSize = getFullBoardSize()
            
            let currentScale = finalScale
            let currentOffset = finalOffset
            
            let screenCenter = CGPoint(x: geometrySize.width / 2, y: geometrySize.height / 2)
            
            let scaledBoardSize = CGSize(width: boardSize.width * currentScale, height: boardSize.height * currentScale)
            let boardTopLeft = CGPoint(
                x: screenCenter.x - (scaledBoardSize.width / 2) + currentOffset.width,
                y: screenCenter.y - (scaledBoardSize.height / 2) + currentOffset.height
            )
            
            let relativeTap = CGPoint(
                x: location.x - boardTopLeft.x,
                y: location.y - boardTopLeft.y
            )
            
            let unscaledTap = CGPoint(
                x: relativeTap.x / currentScale,
                y: relativeTap.y / currentScale
            )
            
            if unscaledTap.x < padding || unscaledTap.x > (boardSize.width - padding) ||
               unscaledTap.y < padding || unscaledTap.y > (boardSize.height - padding) {
                return nil
            }
            
            let tapInGrid = CGPoint(
                x: unscaledTap.x - padding,
                y: unscaledTap.y - padding
            )
            
            let slotSize = constantCellSize + cellSpacing
            
            let col = Int(floor(tapInGrid.x / slotSize))
            let row = Int(floor(tapInGrid.y / slotSize))
            
            let xInSlot = tapInGrid.x.truncatingRemainder(dividingBy: slotSize)
            let yInSlot = tapInGrid.y.truncatingRemainder(dividingBy: slotSize)
            if xInSlot >= constantCellSize || yInSlot >= constantCellSize {
                return nil
            }

            guard row >= 0 && row < state.gameModel.rows && col >= 0 && col < state.gameModel.cols else {
                return nil
            }
            
            return (row, col)
        }}


#Preview {
    let testState = GameState.testState
    
    GameView(state: testState, theme: .classic, send: { action in
         LoggerInfo.log(action)
    })
}






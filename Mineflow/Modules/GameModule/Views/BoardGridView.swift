//
//  BoardGridView.swift
//  Mineflow
//
//  Created by evhn on 11.11.2025.
//

import SwiftUI

struct BoardGridView: View {
    
    let board: [[Cell]]
    let rows: Int
    let cols: Int
    let theme: GameTheme
    
    let cellSpacing: CGFloat
    let padding: CGFloat
    let cellSize: CGFloat
    let finalRadius: CGFloat
    let finalFontSize: CGFloat
    let finalImageSize: CGFloat
    
    let send: (GameAction) -> Void
    
    var body: some View {
        Grid(horizontalSpacing: cellSpacing, verticalSpacing: cellSpacing) {
            ForEach(0..<rows, id: \.self) { row in
                GridRow {
                    ForEach(0..<cols, id: \.self) { col in
                        let cell = board[row][col]
                        
                        CellView(
                            theme: theme,
                            cell: cell,
                            cellCornerRadius: finalRadius,
                            cellFontSize: finalFontSize,
                            cellImageSize: finalImageSize
                        )
                        .frame(width: cellSize, height: cellSize)
                        .onLongPressGesture(minimumDuration: 0.3) {
                            send(.longPressCell(row: row, col: col))
                        }
                    }
                }
            }
        }
        .padding(padding)
        .drawingGroup()
//        .padding(scaleHeight(3))
//
//        .background(
//            RoundedRectangle(cornerRadius: scaleHeight(12))
//        )
    }
}

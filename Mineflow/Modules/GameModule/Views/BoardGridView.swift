//
//  BoardGridView.swift
//  Mineflow
//
//  Created by evhn on 11.11.2025.
//

import SwiftUI

struct BoardGridView: View {
    
    // Входные данные
    let board: [[Cell]]
    let rows: Int
    let cols: Int
    let theme: GameTheme
    
    // Параметры, рассчитанные 1 раз снаружи
    let cellSpacing: CGFloat
    let padding: CGFloat
    let finalRadius: CGFloat
    let finalFontSize: CGFloat
    let finalImageSize: CGFloat
    
    // UDF
    let send: (GameAction) -> Void
    
    var body: some View {
        // ⭐️ ЭТОТ Grid ТЕПЕРЬ КЭШИРУЕТСЯ ⭐️
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
                        .onLongPressGesture(minimumDuration: 0.3) {
                            // ⭐️ Long Press работает!
                            send(.longPressCell(row: row, col: col))
                        }
                    }
                }
            }
        }
        .padding(padding)
        .background(Color.gray.opacity(0.5))
        // ⭐️ .drawingGroup() "сплющивает" этот кэшированный Grid
        .drawingGroup() 
    }
}

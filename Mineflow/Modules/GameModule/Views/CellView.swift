//
//  CellView.swift
//  Mineflow
//
//  Created by evhn on 09.11.2025.
//

import SwiftUI

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
                    if let image = theme.bombImage {
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: scaleHeight(35), height: scaleHeight(35))
                    } else {
                        TextOrIcon(theme.bombIcon)
                    }
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
                    if let image = theme.flagImage {
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: scaleHeight(35), height: scaleHeight(35))

                    } else {
                        TextOrIcon(theme.flagIcon)

                    }
                    
                case .questionMarked:
                    if let question = theme.questionImage {
                        question
                            .resizable()
                            .scaledToFit()
                            .frame(width: scaleHeight(35), height: scaleHeight(35))
                    } else {
                    
                        TextOrIcon(theme.questionMarkIcon)
                    }
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

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
    
    let cellCornerRadius: CGFloat
    let cellFontSize: CGFloat
    let cellImageSize: CGFloat
    
    var cellIsOpenMine: Bool {
        cell.isOpened && cell.isMine
    }
    
    var body: some View {
        ZStack {
            let baseColor = cell.isOpened ? theme.cellOpened : theme.cellClosed
            //            ZStack {
            //                RoundedRectangle(cornerRadius: cellCornerRadius)
            //                    .fill(cellIsOpenMine ? .red : baseColor)
            //                    .aspectRatio(1, contentMode: .fit)
            //                RoundedRectangle(cornerRadius: cellCornerRadius)
            //                    .stroke(Color.black.opacity(0.3), lineWidth: 0.5)
            //                    .aspectRatio(1, contentMode: .fit)
            //            }
            
            
            if cell.isOpened {
                
                ZStack {
                    RoundedRectangle(cornerRadius: cellCornerRadius)
                        .fill(cellIsOpenMine ? Color.bombRed : theme.cellOpened)
                        .aspectRatio(1, contentMode: .fit)
                    
                    RoundedRectangle(cornerRadius: cellCornerRadius)
                        .stroke(Color.black.opacity(0.3), lineWidth: 0.5)
                        .aspectRatio(1, contentMode: .fit)
                }
                if cell.isMine {
                    if let image = theme.bombImage {
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: scaleHeight(cellImageSize), height: scaleHeight(cellImageSize))
                    } else {
                        TextOrIcon(theme.bombIcon)
                    }
                    
                } else if cell.surroundingMines > 0 {
                    Text("\(cell.surroundingMines)")
                        .font(.sofia(weight: .bold700, size: cellFontSize))
                    
                        .foregroundColor(theme.numberColors[cell.surroundingMines - 1])
                } else {
                    EmptyView()
                }
                
            } else {
                
                ZStack {
                    RoundedRectangle(cornerRadius: cellCornerRadius)
                        .fill(theme.cellClosed)
                        .aspectRatio(1, contentMode: .fit)
                    
                    RoundedRectangle(cornerRadius: cellCornerRadius)
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(0.15),
                                    Color.white.opacity(0.0)
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .aspectRatio(1, contentMode: .fit)
                    
                    RoundedRectangle(cornerRadius: cellCornerRadius)
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color.black.opacity(0.0),
                                    Color.black.opacity(0.15)
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .aspectRatio(1, contentMode: .fit)
                }
                
                
                switch cell.flagState {
                case .flagged:
                    if let image = theme.flagImage {
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: scaleHeight(cellImageSize), height: scaleHeight(cellImageSize))
                        
                    } else {
                        TextOrIcon(theme.flagIcon)
                        
                    }
                    
                case .questionMarked:
                    if let question = theme.questionImage {
                        question
                            .resizable()
                            .scaledToFit()
                            .frame(width: scaleHeight(cellImageSize), height: scaleHeight(cellImageSize))
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

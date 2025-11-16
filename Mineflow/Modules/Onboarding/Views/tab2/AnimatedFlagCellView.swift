//
//  AnimatedFlagCellView.swift
//  Mineflow
//
//  Created by evhn on 16.11.2025.
//

import SwiftUI


struct AnimatedFlagCellView: View {
    let isFlagged: Bool
    let isBaseRevealed: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 3)
                .fill(isBaseRevealed ? GameTheme.classic.cellOpened : GameTheme.classic.cellClosed)
            
            if isFlagged {
                Image(.danger2)
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .frame(width: scaleHeight(35), height: scaleHeight(35))
            } else if isBaseRevealed && Int.random(in: 0...5) == 0 {
                Text(String(Int.random(in: 1...3)))
                    .font(.sofia(weight: .bold700, size: 22))
                    .foregroundColor(Color.blue)
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .aspectRatio(1, contentMode: .fit)
    }
}


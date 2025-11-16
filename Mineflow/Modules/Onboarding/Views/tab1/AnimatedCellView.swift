//
//  AnimatedCellView.swift
//  Mineflow
//
//  Created by evhn on 16.11.2025.
//

import SwiftUI

struct AnimatedCellView: View {
    let isRevealed: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 3)
                .fill(isRevealed ? GameTheme.classic.cellClosed : GameTheme.classic.cellOpened)
            
            if isRevealed {
                Text(String(Int.random(in: 1...3)))
                    .font(.sofia(weight: .bold700, size: 22))
                    .fontWeight(.bold)
                    .foregroundColor(numberColor(for: Int.random(in: 1...3)))
                    .transition(.opacity)
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .aspectRatio(1, contentMode: .fit)
    }
    
    private func numberColor(for number: Int) -> Color {
        switch number {
        case 1: return .blue
        case 2: return .green
        case 3: return .red
        default: return .white
        }
    }
}

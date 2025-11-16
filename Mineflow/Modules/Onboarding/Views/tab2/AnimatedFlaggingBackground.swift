//
//  AnimatedFlaggingBackground.swift
//  Mineflow
//
//  Created by evhn on 16.11.2025.
//


import SwiftUI

struct AnimatedFlaggingBackground: View {
    let rows: Int = 8
    let cols: Int = 8
    
    @State private var flaggableCells: [Int: Bool] = [:]
    
    let flagIndices: [Int] = [
        (2 * 8) + 3,
        (4 * 8) + 6,
        (6 * 8) + 2,
        (1 * 8) + 5
    ]
    
    var body: some View {
        VStack(spacing: 1.5) {
            ForEach(0..<rows, id: \.self) { row in
                HStack(spacing: 1.5) {
                    ForEach(0..<cols, id: \.self) { col in
                        let index = row * cols + col
                        
                        AnimatedFlagCellView(
                            isFlagged: flaggableCells[index] ?? false,
                            isBaseRevealed: true
                        )
                        .onAppear {
                            if flagIndices.contains(index) {
                                DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 0.5...2.0)) {
                                    withAnimation(.easeOut(duration: 0.8)) {
                                        flaggableCells[index] = true
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        .background(Color.gray.opacity(0.05))
        .ignoresSafeArea()
    }
}



#Preview {
    AnimatedFlaggingBackground()
        .preferredColorScheme(.dark)
}



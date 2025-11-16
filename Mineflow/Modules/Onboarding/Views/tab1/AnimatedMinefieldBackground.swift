//
//  AnimatedMinefieldBackground.swift
//  Mineflow
//
//  Created by evhn on 16.11.2025.
//


import SwiftUI

struct AnimatedMinefieldBackground: View {
    let rows: Int = 9
    let cols: Int = 9
    
    @State private var revealedCells: [Int: Bool] = [:]
    
    var body: some View {
        VStack(spacing: 1.5) {
            ForEach(0..<rows, id: \.self) { row in
                HStack(spacing: 1.5) {
                    ForEach(0..<cols, id: \.self) { col in
                        let index = row * cols + col
                        
                        AnimatedCellView(isRevealed: revealedCells[index] ?? false)
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 0.1...2.5)) {
                                    withAnimation(.easeOut(duration: 0.6)) {
                                        revealedCells[index] = true
                                    }
                                }
                            }
                    }
                }
            }
        }
        .background(Color.gray.opacity(0.05))
        .ignoresSafeArea()
        .padding()

    }
}



#Preview {
    ZStack {
        Color.bimbBackground.ignoresSafeArea()
        AnimatedMinefieldBackground()

    }
    
}

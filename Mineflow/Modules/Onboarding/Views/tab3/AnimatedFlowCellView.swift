//
//  AnimatedFlowCellView.swift
//  Mineflow
//
//  Created by evhn on 16.11.2025.
//

import SwiftUI

struct AnimatedFlowCellView: View {
    let index: Int
    @Binding var cellPositions: [Int: CGPoint]
    
    private enum CellContentType {
        case empty, number, flag
    }
    
    @State private var contentType: CellContentType = .empty
    @State private var opacity: Double = 0.0
    @State private var scale: CGFloat = 0.8
    @State private var randomNumber: Int = 0
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 3)
                .fill(Color.white.opacity(0.15))
            
            
            if contentType == .number {
                Text(String(randomNumber))
                    .font(.sofia(weight: .bold700, size: 22))
                    .fontWeight(.bold)
                    .foregroundColor(GameTheme.classic.numberColors[randomNumber])
            } else if contentType == .flag {
                Image(.classicFlag)
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .frame(width: scaleHeight(35), height: scaleHeight(35))
            }
        }
        .frame(width: 40, height: 40)
        .opacity(opacity)
        .scaleEffect(scale)
        .onAppear {
            let roll = Int.random(in: 1...5)
            if roll == 1 {
                contentType = .number
                randomNumber = Int.random(in: 1...7)
            } else if roll == 2 {
                contentType = .flag
            } else {
                contentType = .empty
            }
            
            withAnimation(Animation.easeOut(duration: 1.0).delay(Double(index) * 0.05)) {
                opacity = 1.0
                scale = 1.0
            }
        }
    }
}

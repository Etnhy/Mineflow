//
//  AnimatedReadyBackground.swift
//  Mineflow
//
//  Created by evhn on 16.11.2025.
//


import SwiftUI

struct AnimatedReadyBackground: View {
    let rows: Int = 9
    let cols: Int = 9
    
    @State private var cellPositions: [Int: CGPoint] = [:]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.gray.opacity(0.05)
                
                ForEach(0..<(rows * cols), id: \.self) { index in
                    AnimatedFlowCellView(index: index, cellPositions: $cellPositions)
                        .position(cellPositions[index] ?? initialPosition(for: index, geometry: geometry))
                        .onAppear {
                            let initialPos = initialPosition(for: index, geometry: geometry)
                            cellPositions[index] = initialPos
                            let animationDuration = Double.random(in: 4.0...8.0)
                            let delay = Double.random(in: 0.1...3.0)
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                                withAnimation(Animation.linear(duration: animationDuration).repeatForever(autoreverses: false)) {
                                    cellPositions[index] = finalPosition(for: index, geometry: geometry)
                                }
                            }
                        }
                }
            }
        }
        .ignoresSafeArea()
    }
    
    private func initialPosition(for index: Int, geometry: GeometryProxy) -> CGPoint {
        let x = CGFloat.random(in: 0...geometry.size.width)
        let y = CGFloat.random(in: 0...geometry.size.height)
        return CGPoint(x: x, y: y)
    }
    
    private func finalPosition(for index: Int, geometry: GeometryProxy) -> CGPoint {
        let x = CGFloat.random(in: 0...geometry.size.width)
        let y = CGFloat.random(in: 0...geometry.size.height)
        return CGPoint(x: x, y: y)
    }
}


#Preview {
    AnimatedReadyBackground()
        .preferredColorScheme(.dark)
}

//
//  GameStatusOverlay.swift
//  Mineflow
//
//  Created by evhn on 09.11.2025.
//

import SwiftUI


struct GameStatusOverlay: View {
    let status: GameStatus
    let onRestart: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Text(status == .won ? "Победа! 😎" : "Поражение 😵")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.white)
            
            Button("Играть снова", action: onRestart)
                .font(.title2)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.75))
    }
}

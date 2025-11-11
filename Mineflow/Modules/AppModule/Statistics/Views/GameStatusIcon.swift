//
//  GameStatusIcon.swift
//  Mineflow
//
//  Created by evhn on 11.11.2025.
//

import SwiftUI

struct GameStatusIcon: View {
    let status: GameStatus
    let theme: GameTheme
    
    var body: some View {
        let color: Color = (status == .won) ? .green : .red
        let icon: String = (status == .won) ? "checkmark" : "xmark"
        
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(color.opacity(0.2))
                .frame(width: 40, height: 40)
            
            Image(systemName: icon)
                .font(.body.weight(.bold))
                .foregroundColor(color)
        }
    }
}

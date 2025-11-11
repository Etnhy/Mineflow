//
//  GameHeaderView.swift
//  Mineflow
//
//  Created by evhn on 09.11.2025.
//

import SwiftUI

struct GameHeaderView: View {
    let theme: GameTheme
    let status: GameStatus
    let elapsedTime: Double
    let flagsRemaining: Int
    let onRestart: () -> Void
    
    var body: some View {
        HStack {
            Text("🚩 \(flagsRemaining)")
                .font(.system(.title, design: .monospaced).bold())
            
            Spacer()
            
            Button(action: onRestart) {
                Text(smileyForStatus(status))
                    .font(.largeTitle)
            }
            
            Spacer()
            
            Text(String(format: "%.0f", elapsedTime))
                .font(.system(.title, design: .monospaced).bold())
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .background(theme.headerBackgroundColor)
    }
    
    private func smileyForStatus(_ status: GameStatus) -> String {
        switch status {
        case .initial, .playing: return "🙂"
        case .won: return "😎"
        case .lost: return "😵"
        }
    }
}

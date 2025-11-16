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
        HStack(spacing: 8) {
            
            StatBox(
                theme: theme,
                label: "Hints",
                value: "\(flagsRemaining)",
                icon: "flag.fill",
                valueColor: theme.accentColor
            )
            
            Button(action: onRestart) {
                Text(smileyForStatus(status))
                    .font(.sofia(weight: .black900, size: 30))
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
            }
            .background(theme.headerBackgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            
            StatBox(
                theme: theme,
                label: "Flow",
                value: formatTime(elapsedTime),
                icon: "clock.fill",
                valueColor: theme.primaryTextColor
            )
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
        .background(theme.backgroundColor)
    }
    
    
    private func smileyForStatus(_ status: GameStatus) -> String {
        switch status {
        case .initial, .playing: return "🤔"
        case .won: return "WON"
        case .lost: return "LOSE"
        }
    }
    
    private func formatTime(_ time: Double) -> String {
        return String(format: "%.0f", time)
    }
}


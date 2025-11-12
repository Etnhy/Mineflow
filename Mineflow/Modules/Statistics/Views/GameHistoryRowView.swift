//
//  GameHistoryRowView.swift
//  Mineflow
//
//  Created by evhn on 11.11.2025.
//


import SwiftUI

struct GameHistoryRowView: View {
    
    let gameModel: GameModel
    let theme: GameTheme
    
    var body: some View {
        HStack(spacing: 15) {
            
            GameStatusIcon(status: gameModel.status, theme: theme)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(gameModel.gameMode.title)
                    .font(.sofia(weight: .bold700, size: 18))
                    .foregroundColor(theme.primaryTextColor)
                Text(gameModel.date.formatted(.dateTime
                    .day(.twoDigits)
                    .month(.twoDigits)
                    .year()
                    .hour(.twoDigits(amPM: .omitted))
                    .minute(.twoDigits)
                ))
                    .font(.sofia(weight: .regular400, size: 13))
                    .foregroundColor(theme.secondaryTextColor)
                    .lineLimit(1)
            }
            
            Spacer()
            
            Text(String(format: "%.1fs", gameModel.time))
                .font(.system(.title3, design: .monospaced).weight(.bold))
                .foregroundColor(theme.primaryTextColor)
        }
        .padding(12)
        .background(theme.headerBackgroundColor.opacity(0.5))
        .clipShape(RoundedRectangle(cornerRadius: theme.cornerRadius))
    }
}


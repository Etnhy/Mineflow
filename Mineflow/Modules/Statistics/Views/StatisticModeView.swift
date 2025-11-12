//
//  StatisticModeView.swift
//  Mineflow
//
//  Created by evhn on 11.11.2025.
//


import SwiftUI

struct StatisticModeView: View {
    
    let theme: GameTheme
    
    let mode: GameMode
    let allGames: Int
    let wins: Int
    let losses: Int
    
    private var winRate: Double {
        guard allGames > 0 else { return 0.0 }
        return Double(wins) / Double(allGames)
    }
    
    private var winRateText: String {
        return "\(Int(winRate * 100))%"
    }
    
    private func iconForMode() -> String {
        switch mode {
        case .easy:
            return "leaf.fill"
        case .medium:
            return "flame.fill"
        case .hard:
            return "bolt.fill"
        }
    }
    
    var body: some View {
        HStack(spacing: 15) {
            
            VStack(alignment: .leading, spacing: 12) {
                HStack(spacing: 8) {
                    Image(systemName: iconForMode())
                        .font(.title2.weight(.semibold))
                        .foregroundColor(theme.accentColor)
                    Text(mode.title)
                        .font(.sofia(weight: .bold700, size: 22))
                        .foregroundColor(theme.primaryTextColor)
                }
                
                HStack(spacing: 15) {
                    StatItem(theme: theme, title: "Wins", value: "\(wins)", color: .green)
                    StatItem(theme: theme, title: "Losses", value: "\(losses)", color: .red)
                    StatItem(theme: theme, title: "Total", value: "\(allGames)", color: theme.primaryTextColor)
                }
            }
            
            Spacer()
            
            ZStack {
                Circle()
                    .stroke(theme.cellClosed, lineWidth: 10)
                
                Circle()
                    .trim(from: 0.0, to: winRate)
                    .stroke(theme.accentColor, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                    .animation(.spring(), value: winRate)
                
                Text(winRateText)
                    .font(.sofia(weight: .bold700, size: 20))
                    .foregroundColor(theme.primaryTextColor)
            }
            .frame(width: 80, height: 80)
            
        }
        .padding()
        .background(theme.headerBackgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: theme.cornerRadius * 1.5))
        .shadow(color: .black.opacity(0.1), radius: 5, y: 3)
    }
}


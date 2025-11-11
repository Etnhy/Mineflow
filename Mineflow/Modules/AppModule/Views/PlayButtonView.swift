//
//  PlayButtonView.swift
//  Mineflow
//
//  Created by evhn on 10.11.2025.
//

import SwiftUI

//struct PlayButtonView: View {
//    var theme: GameTheme
//    var model: StartGameModel
//    var body: some View {
//        ZStack {
//            theme.headerBackgroundColor
//            Text("\(model.name): \(model.cols)x\(model.rows), \(model.totalMines) bomb")
//                .font(.sofia(weight: .bold700, size: 20))
//                .foregroundStyle(theme.accentColor)
////                .multilineTextAlignment(.leading)
//
//        }
//        .clipShape(RoundedRectangle(cornerRadius: scaleHeight(theme.cornerRadius)))
//        .frame(height: scaleHeight(50))
//        .padding(.horizontal)
//    }
//}

import SwiftUI

struct PlayButtonView: View {
    var theme: GameTheme
    var model: StartGameModel
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: iconForModel())
                .font(.title2.weight(.medium))
                .foregroundColor(theme.accentColor)
                .frame(width: 30)

            VStack(alignment: .leading, spacing: 2) {
                Text(model.gameMode.title)
                    .font(.sofia(weight: .bold700, size: 20))
                    .foregroundColor(theme.primaryTextColor)
                
                Text("\(model.cols)x\(model.rows), \(model.totalMines) bomb")
                    .font(.sofia(weight: .regular400, size: 14))
                    .foregroundColor(theme.secondaryTextColor)
            }
            
            Spacer()
            Image(systemName: "chevron.right")
                .font(.body.weight(.semibold))
                .foregroundColor(theme.secondaryTextColor.opacity(0.5))
        }
        .padding(.horizontal, 20)
        .frame(height: scaleHeight(50))
        .background(theme.headerBackgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: scaleHeight(theme.name == "Classic" ? 5 : theme.cornerRadius)))
        .shadow(color: .black.opacity(0.1), radius: 5, y: 3)
        .padding(.horizontal)
    }
    
    private func iconForModel() -> String {
        switch model.gameMode {
        case .easy:
            return "leaf.fill"
        case .medium:
            return "flame.fill"
        case .hard:
            return "bolt.fill"
        }
    }
}

#Preview {
    ZStack {
        let theme = GameTheme.classic
        theme.backgroundColor.ignoresSafeArea()
        VStack {
            PlayButtonView(
                theme: theme,
                model: .easy
            )
            PlayButtonView(
                theme: theme,
                model: .easy
            )
            PlayButtonView(
                theme: theme,
                model: .easy
            )
        }
    }
}

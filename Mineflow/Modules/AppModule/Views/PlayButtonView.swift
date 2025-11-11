//
//  PlayButtonView.swift
//  Mineflow
//
//  Created by evhn on 10.11.2025.
//

import SwiftUI

struct PlayButtonView: View {
    var theme: GameTheme
    var model: StartGameModel
    var body: some View {
        ZStack {
            theme.accentColor
            Text("\(model.name): \(model.cols)x\(model.rows), \(model.totalMines) bomb")
                .font(.sofia(weight: .semiBold600, size: 18))
                .foregroundStyle(theme.primaryTextColor)

        }
        .clipShape(RoundedRectangle(cornerRadius: scaleHeight(theme.cornerRadius)))
        .frame(height: scaleHeight(50))
        .padding(.horizontal)
    }
}

#Preview {
    PlayButtonView(
        theme: .candy,
        model: .easy
    )
}

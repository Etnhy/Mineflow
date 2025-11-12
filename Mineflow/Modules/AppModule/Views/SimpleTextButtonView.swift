//
//  StatisticButtonView.swift
//  Mineflow
//
//  Created by evhn on 12.11.2025.
//

import SwiftUI

struct SimpleTextButtonView: View {
    var theme: GameTheme
    var title: String
    
    var body: some View {
        ZStack {
            theme.headerBackgroundColor
            Text(title)
                .font(.sofia(weight: .bold700, size: 18))
                .foregroundColor(theme.primaryTextColor)

        }
        .frame(width: multipleWidth(0.7),height: scaleHeight(35))
        .clipShape(RoundedRectangle(cornerRadius: scaleHeight(theme.cornerRadius)))
    }
}

#Preview {
    SimpleTextButtonView(theme: .candy, title: "Statistic")
}

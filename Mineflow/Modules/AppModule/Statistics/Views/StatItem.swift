//
//  StatItem.swift
//  Mineflow
//
//  Created by evhn on 11.11.2025.
//

import SwiftUI

struct StatItem: View {
    let theme: GameTheme
    let title: String
    let value: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.sofia(weight: .regular400, size: 13))
                .foregroundColor(theme.secondaryTextColor)
            Text(value)
                .font(.sofia(weight: .bold700, size: 18))
                .foregroundColor(color)
        }
    }
}




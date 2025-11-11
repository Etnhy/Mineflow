//
//  StatBox.swift
//  Mineflow
//
//  Created by evhn on 11.11.2025.
//

import SwiftUI

struct StatBox: View {
    let theme: GameTheme
    let label: String
    let value: String
    let icon: String
    let valueColor: Color
    
    var body: some View {
        HStack(spacing: 5) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(theme.accentColor)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(label)
                    .font(.caption2)
                    .foregroundColor(theme.secondaryTextColor)
                
                Text(value)
                    .font(.system(.title3, design: .monospaced).weight(.heavy))
                    .foregroundColor(valueColor)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        .background(theme.headerBackgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

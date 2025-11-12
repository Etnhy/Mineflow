//
//  AppThemeSectionView.swift
//  Mineflow
//
//  Created by evhn on 11.11.2025.
//

import SwiftUI

struct AppThemeSectionView: View {
    var theme: GameTheme
    var body: some View {
        HStack {
            Text("App Theme")
                .foregroundColor(theme.accentColor)
                .font(.sofia(weight: .medium500, size: 16))
            Spacer()
            Text(theme.name)
                .foregroundColor(theme.secondaryTextColor)
            Image(systemName: "chevron.right").foregroundColor(.gray)
        }
    }
}

#Preview {
    AppThemeSectionView(theme: .candy)
}

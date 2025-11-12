//
//  SettingsGeneralView.swift
//  Mineflow
//
//  Created by evhn on 11.11.2025.
//

import SwiftUI

struct SettingsGeneralView: View {
    var item: SettingsGeneralCategory
    var theme: GameTheme
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.title)
                    .foregroundColor(theme.accentColor)
                    .font(.sofia(weight: .medium500, size: 16))
                if let subtitle = item.subtitle {
                    Text(subtitle)
                        .foregroundColor(theme.secondaryTextColor)
                        .font(.sofia(weight: .medium500, size: 12))
                }
            }
                
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }    }
}
//
//#Preview {
//    SettingsGeneralView()
//}

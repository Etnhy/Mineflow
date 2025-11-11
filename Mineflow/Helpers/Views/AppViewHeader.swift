//
//  AppViewHeader.swift
//  Mineflow
//
//  Created by evhn on 11.11.2025.
//

import SwiftUI

struct AppViewHeader: View {
    var theme: GameTheme
    var title: String
    var onBack: (() -> Void)?
    
    var body: some View {
        ZStack {
            Text(title)
                .font(.title.weight(.heavy))
                .foregroundColor(theme.primaryTextColor)
            
            HStack {
                if let onBack {
                    Button(action: onBack) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(theme.accentColor)
                            .padding(.leading)
                    }
                    Spacer()
                    
                }
            }
        }
        .frame(height: 50)
    }
}

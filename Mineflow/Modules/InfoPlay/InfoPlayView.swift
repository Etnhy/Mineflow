//
//  InfoPlayView.swift
//  Mineflow
//
//  Created by evhn on 16.11.2025.
//

import SwiftUI

struct InfoPlayView: View {
    var state: InfoPlayState
    var send: (InfoPlayAction) -> Void
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack(alignment: .top) {
            state.theme.headerBackgroundColor.ignoresSafeArea()
            
            VStack(spacing: 0) {
                AppViewHeader(leftIcon: .xmark,theme: state.theme, title: "How to play") {
                    dismiss()
                }
                .padding(.top,scaleHeight(10))
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 25) {
                        
                        InfoRowView(
                            theme: state.theme,
                            iconName: "hand.tap.fill",
                            title: "Tap to Reveal",
                            subtitle: "Tap a tile to open it. The number shows how many hazards are touching that tile."
                        )
                        
                        InfoRowView(
                            theme: state.theme,
                            iconName: "pin.fill",
                            title: "Long-Press to Mark",
                            subtitle: "Press and hold a tile to place a 'Marker'. This helps you keep track of suspected hazards."
                        )
                        
                        InfoRowView(
                            theme: state.theme,
                            iconName: "exclamationmark.triangle.fill",
                            title: "Avoid the Hazards",
                            subtitle: "If you tap a tile hiding a hazard, the game is over."
                        )
                        
                        InfoRowView(
                            theme: state.theme,
                            iconName: "trophy.fill",
                            title: "Objective",
                            subtitle: "Open all tiles that are *not* hazards to win the game. Good luck finding the flow!"
                        )
                        
                    }
                    .padding(.top,scaleHeight(30))
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}


#Preview {
    InfoPlayView(state: .init(theme: .oledDark)) { act in
        print(act)
    }
}


struct InfoRowView: View {
    let theme: GameTheme
    let iconName: String
    let title: String
    let subtitle: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Image(systemName: iconName)
                .font(.title)
                .foregroundColor(theme.accentColor)
                .frame(width: 35)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.sofia(weight: .bold700, size: 18))
                    .foregroundColor(theme.primaryTextColor)
                
                Text(subtitle)
                    .font(.sofia(weight: .regular400, size: 15))
                    .foregroundColor(theme.secondaryTextColor)
                    .lineSpacing(4)
            }
        }
        .frame(maxWidth: .infinity)
        .padding()

        .background(theme.headerBackgroundColor)
    }
}

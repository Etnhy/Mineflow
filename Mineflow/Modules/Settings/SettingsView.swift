//
//  SettingsView.swift
//  Mineflow
//
//  Created by evhn on 06.11.2025.
//

import SwiftUI

struct SettingsView: View {
    var state: SettingsState

    var send: (SettingsAction) -> Void
    
    var body: some View {
        ZStack {
            BackgroundView(theme: state.theme)
            VStack {
                Button {
                    send(.themeMenuTapped)
                } label: {
                    Text("Theme menu")
                }
                
            }
        }
    }
}

#Preview {
    SettingsView(state: .init(theme: .candy),send: { action in
        print(action)
    })
}

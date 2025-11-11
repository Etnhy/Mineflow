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
        
        let hapticIsOnBinding = Binding(
            get: { state.hapticIsOn },
            set: { isToggled in
                send(.hapticToggleChanged(isOn: isToggled))
            }
        )
        
        ZStack {
            BackgroundView(theme: state.theme)
            VStack {
                Button {
                    send(.themeMenuTapped)
                } label: {
                    Text("Theme menu")
                }
                
                Button {
                    
                } label: {
                    HStack {
                        Text("Haptic")
                        Toggle("", isOn: hapticIsOnBinding)
                    }
                }

                
            }
        }
    }
}

#Preview {
    SettingsView(state: .init(theme: .candy, hapticIsOn: false),send: { action in
        print(action)
    })
}

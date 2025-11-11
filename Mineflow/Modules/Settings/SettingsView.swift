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
    
    @Environment(\.dismiss) var dismiss
    var body: some View {

        
        ZStack {
            BackgroundView(theme: state.theme)
            
            VStack(spacing: 0) {
                AppViewHeader(theme: state.theme, title: "Settings") {
                    dismiss()
                }
                
                Form {
                    
                    generalSection
                    
                    themeSection
                    
                    gameSettingsSection
                    
                }
                .scrollContentBackground(.hidden)
                .padding(.top, 1)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
    }
    
    
    private var generalSection: some View {
        Section(header: Text("General").foregroundColor(state.theme.primaryTextColor)) {
            ForEach(SettingsGeneralCategory.allCases,id: \.rawValue) { item in
                Button {
                    
                } label: {
                    SettingsGeneralView(item: item, theme: state.theme)
                    
                }
                
            }
        }
        .listRowBackground(state.theme.headerBackgroundColor)
        
    }
    
    
    private var themeSection: some View {
        Section(header: Text("Appearance").foregroundColor(state.theme.primaryTextColor)) {
            
            Button {
                send(.themeMenuTapped)
            } label: {
                AppThemeSectionView(theme: state.theme)
            }
        }
        .listRowBackground(state.theme.headerBackgroundColor)
        
    }
    
    
    @ViewBuilder
    private var gameSettingsSection: some View {
        
        let hapticIsOnBinding = Binding(
            get: { state.hapticIsOn },
            set: { isToggled in
                send(.hapticToggleChanged(isOn: isToggled))
            }
        )
        
        
        Section(header: Text("Game Settings").foregroundColor(state.theme.primaryTextColor)) {
            
            Toggle("Haptic Feedback", isOn: hapticIsOnBinding)
                .tint(state.theme.accentColor)
                .foregroundColor(state.theme.primaryTextColor)
        }
        .listRowBackground(state.theme.headerBackgroundColor)
        
    }
}

#Preview {
    SettingsView(state: .init(theme: .candy, hapticIsOn: false),send: { action in
        print(action)
    })
}



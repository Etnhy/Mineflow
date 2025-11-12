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
        .safeAreaInset(edge: .bottom) {
            Text("\(state.appVersion)")
                .foregroundStyle(state.theme.accentColor)
                .font(.sofia(weight: .medium500, size: 16))
                .padding(.bottom,scaleHeight(60))
        }
    }
    
    private var generalSection: some View {
        Section(header: Text("General").foregroundColor(state.theme.accentColor)) {
            ForEach(SettingsGeneralCategory.allCases,id: \.rawValue) { general in
                if general == .share {
                    ShareLink(item: URL(string: AppConstants.shareLink)!) {
                        SettingsGeneralView(item: general, theme: state.theme)
                    }
                } else {
                    Button {
                        generalAction(general)
                    } label: {
                        SettingsGeneralView(item: general, theme: state.theme)
                        
                    }

                }
                
            }
        }
        .listRowBackground(state.theme.headerBackgroundColor)
        
    }
    
    
    private var themeSection: some View {
        Section(header: Text("Appearance").foregroundColor(state.theme.accentColor)) {
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
        Section(header: Text("Game Settings").foregroundColor(state.theme.accentColor)) {
            Toggle("Haptic Feedback", isOn: hapticIsOnBinding)
        }
        .listRowBackground(state.theme.headerBackgroundColor)
        .foregroundStyle(state.theme.accentColor)
        .font(.sofia(weight: .medium500, size: 16))

    }
    
    private func generalAction(_ action: SettingsGeneralCategory) {
        switch action {
        case .feedback:
            send(.urlOpened(urlString: AppConstants.feedbackLink))
        case .privacy:
            send(.urlOpened(urlString: AppConstants.privacyLink))
        case .terms:
            send(.urlOpened(urlString: AppConstants.termsLink))
        default: break
            
        }
    }
}

#Preview {
    SettingsView(state: .init(theme: .classic, hapticIsOn: false),send: { action in
        LoggerInfo.log(action)

    })
}



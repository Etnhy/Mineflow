//
//  AppViewHeader.swift
//  Mineflow
//
//  Created by evhn on 11.11.2025.
//

import SwiftUI

struct RightActionModel {
    var icon: String
    var action: () -> Void
}

struct AppViewHeader: View {
    enum HeaderLeftIcon: String {
        case chevron = "chevron.left"
        case xmark = "xmark"
    }
    var leftIcon: HeaderLeftIcon = .chevron
    
    var theme: GameTheme
    var title: String
    var onBack: (() -> Void)?
    var rightAction: RightActionModel?
    
    
    var body: some View {
        ZStack {
            Text(title)
                .font(.title.weight(.heavy))
                .foregroundColor(theme.primaryTextColor)
            
            HStack {
                if let onBack {
                    Button(action: onBack) {
                        Image(systemName: leftIcon.rawValue)
                            .font(.title2)
                            .foregroundColor(theme.accentColor)
                            .padding(.leading)
                    }
                    Spacer()
                    
                }
                
                if let rightAction {
                    Spacer()
                    Button {
                        rightAction.action()
                    } label: {
                        Image(systemName: rightAction.icon)
                            .font(.title2)

                    }
                    .foregroundColor(theme.accentColor)

                    .padding(.trailing)

                }
            }
        }
        .frame(height: 50)
    }
}

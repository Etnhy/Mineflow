//
//  OnboardingView.swift
//  Mineflow
//
//  Created by evhn on 12.11.2025.
//

import SwiftUI

struct OnboardingView: View {
    
    var state: OnboardingState
    
    var send: (OnboardingAction) -> Void
    
    var body: some View {
        let index = min(state.currentIndex, state.onboardingModels.count - 1)
        let model = state.onboardingModels[index]
        ZStack(alignment: .top) {
            VStack {
                Text(model.title)
                Text(model.subtitle)

            }
        }
        .onChange(of: state.currentIndex) { currentIndex in
            LoggerInfo.log(currentIndex)
        }
        .safeAreaInset(edge: .bottom) {
            Button {
                send(.next)
                
            } label: {
                Text(model.buttonTitle)
            }

        }
    }
}

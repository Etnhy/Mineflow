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
            Color.bimbBackground.ignoresSafeArea()
            VStack {
                VStack {
                    Text(model.title)
                        .font(.sofia(weight: .black900, size: 24))
                    Text(model.subtitle)
                        .font(.sofia(weight: .semiBold600, size: 18))
                    Spacer()
                }
                .frame(height: scaleHeight(140))
                model.image
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .shadow(radius: 10)
            }
            .padding(.horizontal)
            .multilineTextAlignment(.center)
        }
        .onChange(of: state.currentIndex) { currentIndex in
            LoggerInfo.log(currentIndex)
        }
        .animation(.linear, value: state.currentIndex)
        .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .trailing)))

        .safeAreaInset(edge: .bottom) {
            Button {
                send(.next)
                
            } label: {
                Text(model.buttonTitle)
            }

        }
    }
}

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
                        .font(.sofia(weight: .black900, size: 32))
                    Text(model.subtitle)
                        .font(.sofia(weight: .bold700, size: 20))
                    Spacer()
                }
                .frame(height: scaleHeight(140))
                .padding(.top,scaleHeight(12))
                .foregroundStyle(.white)
//                model.image
//                    .resizable()
//                    .aspectRatio(1, contentMode: .fit)
//                    .shadow(radius: 10)
                animationView
            }
            .padding(.horizontal)
            .multilineTextAlignment(.center)
            .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .trailing)))
            .animation(.linear, value: state.currentIndex)

        }
        .onChange(of: state.currentIndex) { currentIndex in
            LoggerInfo.log(currentIndex)
        }

        .safeAreaInset(edge: .bottom) {
            Button {
                send(.next)
                
            } label: {
                ZStack {
                    Color.white
                    Text(model.buttonTitle)
                        .font(.sofia(weight: .bold700, size: 22))
                        .foregroundStyle(.black)
                }
                .frame(height: scaleHeight(50))
                .clipShape(RoundedRectangle(cornerRadius: scaleHeight(15)))
            }
            .padding(.horizontal)
            .padding(.bottom,scaleHeight(10))

        }
    }
    
    @ViewBuilder
    private var animationView: some View {
        switch state.currentIndex {
        case 0:
            AnimatedMinefieldBackground()
        case 1:
            AnimatedFlaggingBackground()
        case 2:
            AnimatedReadyBackground()
        default: EmptyView()
        }
    }
}


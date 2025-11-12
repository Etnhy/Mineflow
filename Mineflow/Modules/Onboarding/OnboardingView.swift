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
        ZStack {
            VStack {
                Button {
                    send(.completed)
                } label: {
                    Text("Completed")
                }

            }
        }
    }
}

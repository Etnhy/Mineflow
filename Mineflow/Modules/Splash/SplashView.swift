//
//  SplashView.swift
//  Mineflow
//
//  Created by evhn on 12.11.2025.
//

import SwiftUI
import AppTrackingTransparency

struct SplashView: View {
    var state: SplashState
    var send: (SplashAction) -> Void

    var body: some View {
        ZStack {
            Color.bimbBackground.ignoresSafeArea()
            Image(.appBimb)
                .resizable()
                .scaledToFit()
                .frame(width: 323, height: 284, alignment: .center)
                .aspectRatio(1, contentMode: .fit)
        }
        .ignoresSafeArea()
        .onAppear { send(.onAppear) }
    }
}

//#Preview {
//    Splash()
//}

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
            Color.black.ignoresSafeArea()
        }
        .onAppear { send(.onAppear) }
    }
}

//#Preview {
//    Splash()
//}

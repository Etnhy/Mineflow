//
//  BackgroundView.swift
//  Mineflow
//
//  Created by evhn on 06.11.2025.
//

import SwiftUI

struct BackgroundView: View {
    var theme: GameTheme
    var body: some View {
        theme.backgroundColor.ignoresSafeArea()
    }
}

//#Preview {
//    BackgroundView()
//}

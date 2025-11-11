//
//  BannerAdsView.swift
//  Mineflow
//
//  Created by evhn on 11.11.2025.
//

import SwiftUI

struct BannerAdsView: View {
    var body: some View {
        ZStack {
            Color.white
            Text("BannerAdsView")
        }
        .frame(height: scaleHeight(70))
        .padding(.bottom,scaleHeight(44))
    }
}

#Preview {
    BannerAdsView()
}

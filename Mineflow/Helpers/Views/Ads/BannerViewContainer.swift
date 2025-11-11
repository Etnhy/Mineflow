//
//  BannerViewContainer.swift
//  Mineflow
//
//  Created by evhn on 11.11.2025.
//

import GoogleMobileAds
import SwiftUI
import UIKit

struct BannerViewContainer: UIViewRepresentable {
    typealias UIViewType = BannerView
    let adSize: AdSize
    
    init(_ adSize: AdSize) {
        self.adSize = adSize
    }
    
    func makeUIView(context: Context) -> BannerView {
        let banner = BannerView(adSize: adSize)
        banner.adUnitID = AppConstants.adsKey
        banner.load(Request())
        banner.delegate = context.coordinator
        return banner
    }
    
    func updateUIView(_ uiView: BannerView, context: Context) {}
    
    func makeCoordinator() -> BannerCoordinator {
        return BannerCoordinator(self)
    }
    
    class BannerCoordinator: NSObject, BannerViewDelegate {
        
        let parent: BannerViewContainer
        
        init(_ parent: BannerViewContainer) {
            self.parent = parent
        }
        
        
        func bannerViewDidReceiveAd(_ bannerView: BannerView) {
            print("DID RECEIVE AD.")
        }
        
        func bannerView(_ bannerView: BannerView, didFailToReceiveAdWithError error: Error) {
            print("FAILED TO RECEIVE AD: \(error.localizedDescription)")
        }
    }
}


struct BannerAdsView: View {
    var body: some View {

        ZStack {
            GeometryReader { geo in
                let adSize = currentOrientationAnchoredAdaptiveBanner(width: scaleWidth(geo.size.width - 40))

                BannerViewContainer(adSize)

            }
        }
        .frame(height: scaleHeight(50))
    }
}

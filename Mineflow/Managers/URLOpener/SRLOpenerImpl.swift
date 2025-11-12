//
//  SRLOpenerImpl.swift
//  Mineflow
//
//  Created by evhn on 12.11.2025.
//

import UIKit

final class SRLOpenerImpl: URLOpener {
    func open(_ urlString: String) {
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }
}

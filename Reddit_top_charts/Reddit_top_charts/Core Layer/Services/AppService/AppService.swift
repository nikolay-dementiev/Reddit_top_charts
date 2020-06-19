//
//  AppService.swift
//  Reddit_top_charts
//
//  Created by Nikolay Dementiev on 16.06.2020.
//  Copyright © 2020 test reddit. All rights reserved.
//

import UIKit

final class AppService {
    // MARK: Props
    static let shared = AppService()
    
    var showNetworkActivity = false {
        didSet {
            showNetworkActivityIndicator(showNetworkActivity)
        }
    }

    // MARK: Private API
    private func showNetworkActivityIndicator(_ value: Bool) {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = value
        }
    }
}

//
//  InitialFlowDelegate.swift
//  Reddit_top_charts
//
//  Created by Nikolay Dementiev on 18.06.2020.
//  Copyright © 2020 test reddit. All rights reserved.
//

import Foundation

protocol InitialFlowDelegate: class {
//    func didReceiveData(_ itemData: TopChartsResponseListingData?, completion: (() -> Void)?)
    func openImageUrlInWebView(urlString: String?)
}

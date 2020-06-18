//
//  WebViewControllerInputOutput.swift
//  Reddit_top_charts
//
//  Created by Nikolay Dementiev on 18.06.2020.
//  Copyright © 2020 test reddit. All rights reserved.
//

import Foundation

protocol WebViewControllerInput: class, AlertPresentable, ActivityIndicator {
    func setupInitialState()
    func renderImageData(fromUrlString urlString: String?)
}

extension WebViewControllerInput {
    func setupInitialState() { }
}

protocol WebViewControllerOutput: class {
    func viewIsReady()
    func cancelDownload()
    func loadData(urlString: String?)
}

extension WebViewControllerOutput {
    func cancelDownload() {}
}

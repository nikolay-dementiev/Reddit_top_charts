//
//  InitialViewInputOutput.swift
//  Reddit_top_charts
//
//  Created by Nikolay Dementiev on 16.06.2020.
//  Copyright © 2020 test reddit. All rights reserved.
//

protocol InitialViewInput: class, AlertPresentable, ActivityIndicator {
    func setupInitialState()
    func renderTopChartsData(_ data: TopChartsResponseListingData?,
                             after: String?,
                             completion: (() -> Void)?)
    func fetchInitialDataPortion()
}

protocol InitialViewOutput: class {
    func viewIsReady()
    func loadData(after: String?,
                  count: Int?,
                  completion: (() -> Void)?)
    func openImageUrlInWebView(urlString: String?)
}

extension InitialViewInput {
    func setupInitialState() {}
}

protocol TopCellProtocol: class {
    func thumbnailTappedAction(urlString: String?)
}

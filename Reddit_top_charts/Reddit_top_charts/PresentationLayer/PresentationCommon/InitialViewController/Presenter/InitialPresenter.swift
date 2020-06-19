//
//  InitialPresenter.swift
//  Reddit_top_charts
//
//  Created by Nikolay Dementiev on 16.06.2020.
//  Copyright © 2020 test reddit. All rights reserved.
//

import Foundation

final class InitialPresenter {
    private enum Settings {
        static let limitForDataFetching: Int = 10
        static let isFirstLaunchKey = "isFirstLaunchKey"
    }
    // MARK: Props
    weak var view: InitialViewInput!
    weak var flowDelegate: InitialFlowDelegate?

    // MARK: Private Props
    private let restService = TopService()
}

extension InitialPresenter: InitialViewOutput {
    func viewIsReady() {
        view.setupInitialState()
        if !UserDefaults.standard.bool(forKey: Settings.isFirstLaunchKey) {
            view.fetchInitialDataPortion()
            
            UserDefaults.standard.set(true, forKey: Settings.isFirstLaunchKey)
            UserDefaults.standard.synchronize()
        }
    }
    

    func loadData(after: String? = nil,
                  count: Int? = nil,
                  completion: (() -> Void)? = nil) {
        view.startAnimate()
        let params = TopRequestParams(limit: Settings.limitForDataFetching,
                                      after: after,
                                      count: count)
        
        restService.getTopCharts(with: params) { [weak self] (result) in
            self?.view.stopAnimate()
            
            switch result {
            case .success(let items):
                self?.view.renderTopChartsData(items,
                                               after: after,
                                               completion: completion)
            case .failure(let error):
                self?.view.showAlert(title: nil,
                                     message: error.localizedDescription)
            }
        }
    }
    
    func openImageUrlInWebView(urlString: String?) {
        flowDelegate?.openImageUrlInWebView(urlString: urlString)
    }
}

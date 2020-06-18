//
//  InitialPresenter.swift
//  Reddit_top_charts
//
//  Created by Nikolay Dementiev on 16.06.2020.
//  Copyright © 2020 test reddit. All rights reserved.
//

final class InitialPresenter {
    private enum Settings {
        static let limitForDataFetching: Int = 10
    }
    // MARK: - Props
    weak var view: InitialViewInput!
//    weak var flowDelegate: InitialFlowDelegate?

    // MARK: - Private Props
    private let restService = TopService()

}

extension InitialPresenter: InitialViewOutput {
    func viewIsReady() {
        view.setupInitialState()
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
                                               completion: completion)
//                self?.flowDelegate?.didReceiveData(items, completion: completion)
                
            case .failure(let error):
                self?.view.showAlert(title: nil,
                                     message: error.localizedDescription)
            }
        }
        
    }
    
//    func didSearchAction(for code: String?) {
////        view.startAnimate()
////
////        guard let code = code else { return }
////        let params = FiveDayForecastRequestParams.init(countryName: code)
////
////        restService.getFiveDaysForecast(with: params) { [weak self] (result) in
////            self?.view.stopAnimate()
////
////            switch result {
////            case .success(let items):
////                self?.flowDelegate?.didReceiveFiveDaysForecast(items)
////            case .failure(let error):
////                self?.view.showAlert(title: nil,
////                                     message: error.localizedDescription)
////            }
////        }
//    }

}

//
//  InitialPresenter.swift
//  Reddit_top_charts
//
//  Created by Nikolay Dementiev on 16.06.2020.
//  Copyright © 2020 test reddit. All rights reserved.
//

class InitialPresenter {

    // MARK: - Props
    weak var view: InitialViewInput!
//    weak var flowDelegate: FiveDaysForecastFlowDelegate?

    // MARK: - Private Props
//    private let restService = FiveDayForecastService()

}


extension InitialPresenter: InitialViewOutput {
    func viewIsReady() {
        view.setupInitialState()
    }

    func didSearchAction(for code: String?) {
//        view.startAnimate()
//
//        guard let code = code else { return }
//        let params = FiveDayForecastRequestParams.init(countryName: code)
//
//        restService.getFiveDaysForecast(with: params) { [weak self] (result) in
//            self?.view.stopAnimate()
//
//            switch result {
//            case .success(let items):
//                self?.flowDelegate?.didReceiveFiveDaysForecast(items)
//            case .failure(let error):
//                self?.view.showAlert(title: nil,
//                                     message: error.localizedDescription)
//            }
//        }
    }

}

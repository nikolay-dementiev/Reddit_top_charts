//
//  TopService.swift
//  Reddit_top_charts
//
//  Created by Nikolay Dementiev on 16.06.2020.
//  Copyright © 2020 test reddit. All rights reserved.
//

import Foundation

//typealias ListForecastItem = FiveDaysForecastResponseItem.ListForecastResponseItem

class TopService {
    typealias TopServiceCompletion = (Result<[Any]>) -> ()

    // MARK: - Private Props
    private var networkService = NetworkService()

    // MARK: - API
    func getFiveDaysForecast(with params: TopRequestParams,
                             completion: @escaping TopServiceCompletion) {

        let request = Request(method: .get,
                              endpoint: EndPoint.top,
                              params: params.toJson)

//        networkService.execute(request) { (result: Result<Codable>) in
////            switch result {
////            case .success(let response):
////                completion(.success(response.forecastList))
////            case .failure(let error):
////                completion(.failure(error))
////            }
//            completion(.failure(NetworkError.common("TEST")))
//        }
    }

}

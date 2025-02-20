//
//  TopService.swift
//  Reddit_top_charts
//
//  Created by Nikolay Dementiev on 16.06.2020.
//  Copyright © 2020 test reddit. All rights reserved.
//

import Foundation

class TopService {
    typealias TopServiceCompletion = (Result<TopChartsResponseListingData?, Error>) -> ()

    // MARK: Private Props
    private var networkService = NetworkService()

    // MARK: API
    func getTopCharts(with params: TopRequestParams,
                      completion: @escaping TopServiceCompletion) {

        let request = Request(method: .get,
                              endpoint: EndPoint.top,
                              params: params.toJson)

        networkService.execute(request) { (result: Result<TopChartsResponseItem, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response.data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

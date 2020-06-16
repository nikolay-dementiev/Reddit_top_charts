//
//  NetworkService.swift
//  Reddit_top_charts
//
//  Created by Nikolay Dementiev on 16.06.2020.
//  Copyright © 2020 test reddit. All rights reserved.
//

import Foundation

class NetworkService: NetworkServiceProtocol {
    //MARK: - Props
    var configuration: ServerConfig
    var headers: HeadersDict
    var client = NetworkClient(urlSession: .shared)

    // MARK: - Initialization
    convenience init() {
        self.init(ServerConfig.defaultConfig())
    }

    required init(_ configuration: ServerConfig) {
        self.configuration = configuration
        self.headers = self.configuration.headers // fillup with initial headers
    }

    // MARK: - API
    func execute<Response>(_ request: RequestProtocol,
                           completion: @escaping (_ result: Result<Response>) -> ()) where Response: Codable {
        do {
            guard let urlRequest = try request.urlRequest(in: self) else {
                completion(.failure(NetworkError.invalidURL(request.endpoint)))
                return
            }

            AppService.shared.showNetworkActivity = true
            client.send(urlRequest) {[weak self] (response) in
                AppService.shared.showNetworkActivity = false
                switch response {
                case let .success(urlResponse: resp, data: data, request: _):
                    do {
                        if self?.configuration.emptyDataStatusCodes.contains(resp.statusCode) == true {
                            let empty = String() as! Response
                            completion(.success(empty))
                        } else {
                            let mapped = try JSONDecoder().decode(Response.self, from: data)
                            completion(.success(mapped))
                        }
                    } catch {
                        let err = NetworkError.stringFailedToDecode(data, info: error.localizedDescription)
                        completion(.failure(err))
                    }
                case let .failure(error: err, request: _):
                    completion(.failure(err))
                }
            }
        } catch {
            completion(.failure(NetworkError.undefinedError))
        }
    }

}


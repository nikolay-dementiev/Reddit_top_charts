//
//  RequestProtocol.swift
//  Reddit_top_charts
//
//  Created by Nikolay Dementiev on 16.06.2020.
//  Copyright © 2020 test reddit. All rights reserved.
//

import Foundation

public enum RequestMethod: String {
    case get    = "GET"
    case post   = "POST"
}

protocol RequestProtocol {
    var endpoint: String { get  }

    var method: RequestMethod? { get set }

    /// Optional headers to append to the request.
    var headers: HeadersDict? { get set }
    var timeout: TimeInterval? { get }
    var parameters: JSON? { get set }

    /// Combine the specific request headers with the service's list
    func headers(in service: NetworkServiceProtocol) -> HeadersDict

    func urlRequest(in service: NetworkServiceProtocol) throws -> URLRequest?
}

extension RequestProtocol {
    var parameters: JSON? { return nil }

    var timeout: TimeInterval? {
        return 40.0
    }

    func headers(in service: NetworkServiceProtocol) -> HeadersDict {
        var params: HeadersDict = service.headers
        self.headers?.forEach({ k,v in params[k] = v })
        return params
    }

    func urlRequest(in service: NetworkServiceProtocol) throws -> URLRequest? {
        let requestUrlBase = service.configuration.baseUrl.appending(self.endpoint)
        guard let requestURL = URL(string: requestUrlBase) else { return nil }

        let cachePolicy = URLRequest.CachePolicy.useProtocolCachePolicy

        let timeout = self.timeout ?? service.configuration.timeout
        let headers = self.headers(in: service)

        var urlRequest = URLRequest(url: requestURL,
                                    cachePolicy: cachePolicy,
                                    timeoutInterval: timeout)

        urlRequest.httpMethod = (self.method ?? .get).rawValue
        urlRequest.allHTTPHeaderFields = headers

        switch self.method {
        case .post? :
            if let parameters = self.parameters {
                urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            }
        default:
            let fullURLString = try requestUrlBase.stringByAdding(urlEncodedFields: self.parameters)
            urlRequest.url = URL(string: fullURLString)
        }

        return urlRequest
    }
}

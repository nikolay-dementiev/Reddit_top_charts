//
//  NetworkServiceProtocol.swift
//  Reddit_top_charts
//
//  Created by Nikolay Dementiev on 16.06.2020.
//  Copyright © 2020 test reddit. All rights reserved.
//

protocol NetworkServiceProtocol {
    var configuration: ServerConfig { get }
    var headers: HeadersDict { get }

    init(_ configuration: ServerConfig)
    func execute<Response>(_ request: RequestProtocol, completion: @escaping (_ result: Result<Response, Error>) -> ()) where Response: Codable
}

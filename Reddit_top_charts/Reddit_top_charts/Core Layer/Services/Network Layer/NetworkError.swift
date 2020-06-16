//
//  NetworkError.swift
//  Reddit_top_charts
//
//  Created by Nikolay Dementiev on 16.06.2020.
//  Copyright © 2020 test reddit. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case undefinedError
    case dataIsNotEncodable(_: Any)
    case stringFailedToDecode(_: Data, info: String)
    case invalidURL(_: String)
    case networkRequestError(_: Int, description: String)
    case missingHTTPResponse
    case swiftError(String)
    case common(String?)
}


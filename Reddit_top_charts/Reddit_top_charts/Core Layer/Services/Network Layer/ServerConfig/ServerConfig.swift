//
//  ServerConfig.swift
//  Reddit_top_charts
//
//  Created by Nikolay Dementiev on 16.06.2020.
//  Copyright © 2020 test reddit. All rights reserved.
//

import Foundation

private enum HostPath: String {
    case base = "https://www.reddit.com"
}

enum EndPoint {
    static let top = "/top.json"
}

struct ServerConfig {
    let baseUrl: String
    let headers: HeadersDict
    let timeout: TimeInterval = 40.0
    let emptyDataStatusCodes: Set<Int> = [400]
    
    private static let requiredParemeters: [String : Any] = ["raw_json": 1]

    // MARK: API
    static func defaultConfig() -> ServerConfig {
        return ServerConfig(baseUrl: HostPath.base.rawValue,
                            headers: ServerConfig.defaultHeaders())
    }

    static func addRequiredParemeters(_ params: JSON?) -> JSON? {
        guard var params = params else { return nil }

        requiredParemeters.forEach { key, value in
            if !params.keys.contains(key) {
                params.updateValue(value, forKey: key)
            }
        }

        return params
    }

    // MARK: Private API
    private static func defaultHeaders() -> HeadersDict {
        return [:]
    }

}

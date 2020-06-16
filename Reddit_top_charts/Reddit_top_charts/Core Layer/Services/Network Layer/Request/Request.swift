//
//  Request.swift
//  Reddit_top_charts
//
//  Created by Nikolay Dementiev on 16.06.2020.
//  Copyright © 2020 test reddit. All rights reserved.
//

import Foundation

final class Request: RequestProtocol {
    var endpoint: String
    var method: RequestMethod?
    var headers: HeadersDict?
    var parameters: JSON?

    init(method: RequestMethod = .get,
         endpoint: String = "",
         params: JSON? = nil) {

        self.method = method
        self.endpoint = endpoint
        self.parameters = ServerConfig.addRequiredParemeters(params)
    }
 }

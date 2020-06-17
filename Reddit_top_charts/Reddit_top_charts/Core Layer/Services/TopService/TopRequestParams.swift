//
//  TopRequestParams.swift
//  Reddit_top_charts
//
//  Created by Nikolay Dementiev on 16.06.2020.
//  Copyright © 2020 test reddit. All rights reserved.
//

struct TopRequestParams {
    let limit: Int?
    let after: String?
    let count: Int?
}

extension TopRequestParams: JSONSerializable {
    var toJson: JSON {
        let values: [String: Any?] = ["limit": limit,
                                      "after": after,
                                      "count": count]
        let valueForReturn = values
            .filter { $0.value != nil }
            .mapValues { $0! } as [String : Any]
        
        return valueForReturn
    }
}

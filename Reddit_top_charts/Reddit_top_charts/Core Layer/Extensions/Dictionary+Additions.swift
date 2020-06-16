//
//  Dictionary+Additions.swift
//  Reddit_top_charts
//
//  Created by Nikolay Dementiev on 16.06.2020.
//  Copyright © 2020 test reddit. All rights reserved.
//

import Foundation

extension Dictionary where Key == String, Value == Any {

    public func urlEncodedString(base: String = "") throws -> String {
        guard self.count > 0 else { return "" }
        let items: [URLQueryItem] = self.compactMap { (key,value) in
            let v = value
            return URLQueryItem(name: key, value: String(describing: v))
        }
        var urlComponents = URLComponents(string: base)!
        urlComponents.queryItems = items
        guard let encodedString = urlComponents.url else {
            throw NetworkError.dataIsNotEncodable(self)
        }
        return encodedString.absoluteString
    }
}

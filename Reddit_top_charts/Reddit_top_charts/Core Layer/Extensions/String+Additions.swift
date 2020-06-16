//
//  String+Additions.swift
//  Reddit_top_charts
//
//  Created by Nikolay Dementiev on 16.06.2020.
//  Copyright © 2020 test reddit. All rights reserved.
//

import Foundation

extension String {
    func stringByAdding(urlEncodedFields fields: JSON?) throws -> String {
        guard let f = fields else { return self }
        return try f.urlEncodedString(base: self)
    }

    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}

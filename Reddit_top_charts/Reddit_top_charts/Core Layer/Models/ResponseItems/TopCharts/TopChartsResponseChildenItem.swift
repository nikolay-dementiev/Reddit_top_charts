//
//  TopChartsResponseChildenItem.swift
//  Reddit_top_charts
//
//  Created by Nikolay Dementiev on 17.06.2020.
//  Copyright © 2020 test reddit. All rights reserved.
//

import Foundation

struct TopChartsResponseChildenItem: Codable {
    let data: TopChartsResponseChildListingData?
    let kind: String?
}

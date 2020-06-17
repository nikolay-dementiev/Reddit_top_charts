//
//  TopChartsResponseItem.swift
//  Reddit_top_charts
//
//  Created by Nikolay Dementiev on 17.06.2020.
//  Copyright © 2020 test reddit. All rights reserved.
//

//bluePrints: https://www.reddit.com/dev/api/oauth#GET_top

import Foundation

struct TopChartsResponseItem: Codable {
    let data: TopChartsResponseListingData?
    let kind: String?
}

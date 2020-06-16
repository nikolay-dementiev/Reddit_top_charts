//
//  JSONSerializable.swift
//  Reddit_top_charts
//
//  Created by Nikolay Dementiev on 16.06.2020.
//  Copyright © 2020 test reddit. All rights reserved.
//

protocol JSONSerializable {
    var toJson: JSON {get}
}

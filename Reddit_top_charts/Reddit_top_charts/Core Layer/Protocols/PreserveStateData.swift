//
//  PreserveStateData.swift
//  Reddit_top_charts
//
//  Created by Nikolay Dementiev on 19.06.2020.
//  Copyright © 2020 test reddit. All rights reserved.
//

import Foundation

protocol EncodeDataForStateSaving {
    associatedtype DataType
    func encodeRestorableState(with coder: NSCoder, data: DataType?)
}

protocol DencodeDataForStateRestoring {
    associatedtype DataType
    func decodeRestorableState(with coder: NSCoder) -> DataType?
}

protocol PreserveDataForState: class, EncodeDataForStateSaving & DencodeDataForStateRestoring {
}

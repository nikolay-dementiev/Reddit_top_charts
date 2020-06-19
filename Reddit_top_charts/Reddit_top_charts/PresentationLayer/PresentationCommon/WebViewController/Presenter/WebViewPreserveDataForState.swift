//
//  WebViewPreserveDataForState.swift
//  Reddit_top_charts
//
//  Created by Nikolay Dementiev on 19.06.2020.
//  Copyright © 2020 test reddit. All rights reserved.
//

import Foundation

struct SaveRestoreStateDataWebViewVcDTO {
    enum Keys: String, CaseIterable {
        case dataSourceUrlString = "dataSourceUrlString"
    }
    var dataSourceUrlString: String?
}

final class WebViewPreserveDataForState: PreserveDataForStateBase, PreserveDataForState {
    typealias DataType = SaveRestoreStateDataWebViewVcDTO
    
    func encodeRestorableState(with coder: NSCoder, data: DataType?) {
        guard let data = data else { return }
        
        if let value = data.dataSourceUrlString {
            coder.encode(value, forKey: DataType.Keys.dataSourceUrlString.rawValue)
        }
    }
    
    func decodeRestorableState(with coder: NSCoder) -> DataType? {
        var valueForReturn = DataType()
        
        type(of: valueForReturn)
            .Keys
            .allCases
            .map { $0.rawValue }
            .forEach { keyName in
                switch keyName {
                case DataType.Keys.dataSourceUrlString.rawValue:
                    if let value = coder.decodeObject(forKey: keyName) as? String {
                        valueForReturn.dataSourceUrlString = value
                    }
                default:
                    break
                }
        }
        
        return valueForReturn
    }
}

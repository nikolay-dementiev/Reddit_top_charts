//
//  InitialPreserveDataForState.swift
//  Reddit_top_charts
//
//  Created by Nikolay Dementiev on 19.06.2020.
//  Copyright © 2020 test reddit. All rights reserved.
//

import Foundation

struct SaveRestoreStateDataInitialVcDTO {
    enum Keys: String, CaseIterable {
        case dataSource = "dataSource"
    }
    var dataSource: TopChartsResponseListingData?
}

final class InitialPreserveDataForState: PreserveDataForStateBase, PreserveDataForState {
    typealias DataType = SaveRestoreStateDataInitialVcDTO
    
    func encodeRestorableState(with coder: NSCoder, data: DataType?) {
        guard let data = data else { return }
        
        if let dataSource = data.dataSource {
            if let values = try? jsonEncoderService.encode(dataSource) {
                coder.encode(values, forKey: SaveRestoreStateDataInitialVcDTO.Keys.dataSource.rawValue)
            }
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
                case SaveRestoreStateDataInitialVcDTO.Keys.dataSource.rawValue:
                    if let value = coder.decodeObject(forKey: keyName) as? Data {
                    if let values = try? jsonDecoderService.decode(TopChartsResponseListingData.self, from: value) {
                        valueForReturn.dataSource = values
                        }
                    }
                default:
                    break
                }
        }
        
        return valueForReturn
    }
}

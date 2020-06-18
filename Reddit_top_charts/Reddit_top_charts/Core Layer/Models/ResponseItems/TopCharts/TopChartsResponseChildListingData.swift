//
//  TopChartsResponseChildListingData.swift
//  Reddit_top_charts
//
//  Created by Nikolay Dementiev on 17.06.2020.
//  Copyright © 2020 test reddit. All rights reserved.
//

import Foundation

struct TopChartsResponseChildListingData: Codable {
    let title: String?
    let author: String?
    let thumbnail: String?
    var previewImagesSourceUrl: String? {
        preview?.images?.first?.source?.url
    }
    let created_utc: Date?
    let num_comments: Int?
    private let preview: TopChartsResponseListingPreview?
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        author = try values.decodeIfPresent(String.self, forKey: .author)
        thumbnail = try values.decodeIfPresent(String.self, forKey: .thumbnail)
        if let dateTemp = try values.decodeIfPresent(Double.self, forKey: .created_utc) {
            created_utc = Date(timeIntervalSince1970: dateTemp)
        } else {
            created_utc = nil
        }
        num_comments = try values.decodeIfPresent(Int.self, forKey: .num_comments)
        preview = try values.decodeIfPresent(TopChartsResponseListingPreview.self, forKey: .preview)
    }
}

private struct TopChartsResponseListingPreview: Codable {
    let enabled: Bool?
    let images: [TopChartsResponseListingImage]?
}

private struct TopChartsResponseListingImage: Codable {
    let id: String?
    let resolutions: [TopChartsResponseListingResizedIcon]?
    let source: TopChartsResponseListingResizedIcon?
}

private struct TopChartsResponseListingResizedIcon: Codable {
    let height: Int?
    let url: String?
    let width: Int?
}

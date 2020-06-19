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
    let created_utc: Double?
    let num_comments: Int?
    let preview: TopChartsResponseListingPreview?
    //
    let previewImagesSourceUrl: String?
    let createdDate: Date?
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case author = "author"
        case thumbnail = "thumbnail"
        case created_utc = "created_utc"
        case num_comments = "num_comments"
        case preview = "preview"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        author = try values.decodeIfPresent(String.self, forKey: .author)
        thumbnail = try values.decodeIfPresent(String.self, forKey: .thumbnail)
        created_utc = try values.decodeIfPresent(Double.self, forKey: .created_utc)
        num_comments = try values.decodeIfPresent(Int.self, forKey: .num_comments)
        preview = try values.decodeIfPresent(TopChartsResponseListingPreview.self, forKey: .preview)
        //
        previewImagesSourceUrl = preview?.images?.first?.source?.url
        if let created_utc = created_utc {
            createdDate = Date(timeIntervalSince1970: created_utc)
        } else {
            createdDate = nil
        }
    }
}

struct TopChartsResponseListingPreview: Codable {
    let enabled: Bool?
    let images: [TopChartsResponseListingImage]?
}

struct TopChartsResponseListingImage: Codable {
    let id: String?
    let resolutions: [TopChartsResponseListingResizedIcon]?
    let source: TopChartsResponseListingResizedIcon?
}

struct TopChartsResponseListingResizedIcon: Codable {
    let height: Int?
    let url: String?
    let width: Int?
}

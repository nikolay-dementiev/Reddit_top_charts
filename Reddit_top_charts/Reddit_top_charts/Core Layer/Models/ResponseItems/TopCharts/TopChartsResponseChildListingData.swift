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
    let createdUtc: Float?
    let numComments: Int?
    private let preview: TopChartsResponseListingPreview?
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

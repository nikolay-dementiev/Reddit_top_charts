//
//	TopChartsResponseListingData.swift

import Foundation

struct TopChartsResponseListingData: Codable {
	let after: String?
	let before: String?
	var children: [TopChartsResponseChildenItem]?
	let dist: Int?
	let modhash: String?
}

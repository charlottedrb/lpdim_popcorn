// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topMovies = try? newJSONDecoder().decode(TopMovies.self, from: jsonData)

import Foundation

// MARK: - TopMovies
struct TopMovies: Codable {
    let page: Int
    let results: [Movie]
    let totalResults, totalPages: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}

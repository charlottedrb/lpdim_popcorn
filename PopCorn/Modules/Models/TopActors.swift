// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topActors = try? newJSONDecoder().decode(TopActors.self, from: jsonData)

import Foundation

// MARK: - TopActors
struct TopActors: Codable {
    let page: Int
    let results: [TopActor]
    let totalResults, totalPages: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}

// MARK: - Result
struct TopActor: Codable {
    let profilePath: String?
    let adult: Bool?
    let id: Int
    let knownFor: [Movie]
    let name: String?
    let popularity: Double?

    enum CodingKeys: String, CodingKey {
        case profilePath = "profile_path"
        case adult, id
        case knownFor = "known_for"
        case name, popularity
    }
}

enum MediaType: String, Codable {
    case movie = "movie"
    case tv = "tv"
}

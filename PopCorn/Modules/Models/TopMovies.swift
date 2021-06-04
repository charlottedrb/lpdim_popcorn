// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topMovies = try? newJSONDecoder().decode(TopMovies.self, from: jsonData)

import Foundation

// MARK: - TopMovies
struct TopMovies: Codable {
    let page: Int
    let results: [TopMovie]
    let totalResults, totalPages: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}

// MARK: - TopMovie
struct TopMovie: Codable {
    let posterPath: String?
    let adult: Bool?
    let overview, releaseDate: String
    let genreIDS: [Int]
    let id: Int?
    let originalTitle: String?
    let title, backdropPath: String?
    let popularity: Double?
    let voteCount: Int?
    let video: Bool?
    let voteAverage: Double?

    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case adult, overview
        case releaseDate = "release_date"
        case genreIDS = "genre_ids"
        case id
        case originalTitle = "original_title"
        case title
        case backdropPath = "backdrop_path"
        case popularity
        case voteCount = "vote_count"
        case video
        case voteAverage = "vote_average"
    }
}

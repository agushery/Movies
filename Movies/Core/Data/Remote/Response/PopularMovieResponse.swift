//
//  PopularMovieResponse.swift
//  Movies
//
//  Created by Agus Hery on 12/02/23.
//  Copyright © 2023 Agus Hery. All rights reserved.
//


import Foundation


// MARK: - PopularMovieResponse

/// Struct representing the popular movie response received from the API.
struct PopularMovieResponse: Codable {
    /// The page number of the popular movies.
    let page: Int

    /// An array of popular movie objects.
    let results: [PopularMovie]

    /// The total number of pages of popular movies.
    let totalPages: Int

    /// The total number of results of popular movies.
    let totalResults: Int

    /// Coding keys to map the keys in the response to the properties of the struct.
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - PopularMovie

/// Struct representing the popular movie object received from the API.
struct PopularMovie: Codable {

    /// A Boolean value indicating whether the movie is intended for adults only.
    let adult: Bool

    /// The backdrop path of the movie.
    let backdropPath: String

    /// An array of genre IDs associated with the movie.
    let genreIDs: [Int]

    /// The ID of the movie.
    let id: Int

    /// The original language of the movie.
    let originalLanguage: OriginalLanguage

    /// The original title of the movie.
    let originalTitle: String

    /// A brief overview of the movie.
    let overview: String

    /// The popularity score of the movie.
    let popularity: Double

    /// The poster path of the movie.
    let posterPath: String

    /// The release date of the movie.
    let releaseDate: String

    /// The title of the movie.
    let title: String

    /// A Boolean value indicating whether the movie has a video.
    let video: Bool

    /// The average vote score of the movie.
    let voteAverage: Double

    /// The number of votes received for the movie.
    let voteCount: Int

    /// Coding keys to map the keys in the response to the properties of the struct.
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDs = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

// MARK: - OriginalLanguage

/// Enum representing the original language of the movie.
enum OriginalLanguage: String, Codable {
case en = "en"
case es = "es"
case ko = "ko"
case ru = "ru"
}

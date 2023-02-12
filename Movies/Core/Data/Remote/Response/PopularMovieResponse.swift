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
    let results: [MovieResponse]

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

//
//  MoviesResponse.swift
//  Movies
//
//  Created by Agus Hery on 12/02/23.
//  Copyright © 2023 Agus Hery. All rights reserved.
//


import Foundation


// MARK: - MoviesResponse

/// Struct representing the popular and up coming movie response received from the API.
struct MoviesResponse: Codable {
    /// Representing the date range for the movies returned in the response
    let dates: Dates?
    
    /// The page number of the  movies.
    let page: Int

    /// An array of  movie objects.
    let results: [MovieResponse]

    /// The total number of pages of popular movies.
    let totalPages: Int?

    /// The total number of results of popular movies.
    let totalResults: Int?

    /// Coding keys to map the keys in the response to the properties of the struct.
    enum CodingKeys: String, CodingKey {
        case dates, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

/// Struct representing the date range for the movies
struct Dates: Codable {
    /// The maximum date in the range
    let maximum: String
    
    /// The minimum date in the range
    let minimum: String

    /// Coding keys for mapping the keys in the API response to the properties in this struct
    enum CodingKeys: String, CodingKey {
        case maximum
        case minimum
    }
}

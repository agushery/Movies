//
//  PopularMoviesResponse.swift
//  Movies
//
//  Created by Agus Hery on 10/02/23.
//  Copyright © 2023 Agus Hery. All rights reserved.
//

import Foundation

/// Struct representing the response of a movie list API
struct UpComingMoviesResponse: Codable {
    /// Representing the date range for the movies returned in the response
    let dates: Dates
    
    /// The current page of the results
    let page: Int
    
    /// The list of movies in the response
    let results: [MovieResponse]

    /// Coding keys for mapping the keys in the API response to the properties in this struct
    enum CodingKeys: String, CodingKey {
        case dates
        case page
        case results
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

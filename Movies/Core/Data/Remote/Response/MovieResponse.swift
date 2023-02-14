//
//  MovieResponse.swift
//  Movies
//
//  Created by Agus Hery on 12/02/23.
//  Copyright © 2023 Agus Hery. All rights reserved.
//

import Foundation

struct MovieResponse: Codable {
    /// Indicates if the movie is intended for adults
    let adult: Bool
    
    /// The path of the movie's backdrop image
    let backdropPath: String?
    
    /// The genre IDs associated with the movie
    let genreIDs: [Int]
    
    /// The movie's unique identifier
    let id: Int
    
    /// The original language of the movie
    let originalLanguage: String
    
    /// The original title of the movie
    let originalTitle: String
    
    /// A brief overview of the movie
    let overview: String
    
    /// The movie's popularity score
    let popularity: Double
    
    /// The path of the movie's poster image
    let posterPath: String?
    
    /// The release date of the movie
    let releaseDate: String
    
    /// The title of the movie
    let title: String
    
    /// Indicates if the movie has a video
    let video: Bool
    
    /// The average rating for the movie
    let voteAverage: Double
    
    /// The number of votes for the movie
    let voteCount: Int

    /// Coding keys for mapping the keys in the API response to the properties in this struct
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDs = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

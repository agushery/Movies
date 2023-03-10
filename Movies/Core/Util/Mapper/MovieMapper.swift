//
//  MovieMapper.swift
//  Movies
//
//  Created by Agus Hery on 10/02/23.
//  Copyright © 2023 Agus Hery. All rights reserved.
//

import Foundation


/**
 `MovieMapper` is a utility class for converting movie response objects to movie domain objects.
*/
final class MovieMapper {
    
    /**
     Maps an array of MovieResponse objects to an array of MovieModel domain objects.
     
     - parameter movieResponse: An array of PopularMovie response objects to be mapped.
     
     - returns: An array of MovieModel domain objects.
     */
    static func mapMovieResponseToDomains(
        input movieResponse: [MovieResponse]
    ) -> [MovieModel] {
        return movieResponse.map { result in
            return MovieModel(
                backdropPath: result.backdropPath,
                id: String(result.id),
                originalTitle: result.title,
                overview: result.overview,
                popularity: result.popularity,
                posterPath: result.posterPath,
                releaseDate: result.releaseDate,
                title: result.title,
                voteAverage: result.voteAverage,
                voteCount: result.voteCount
            )
        }
    }
}



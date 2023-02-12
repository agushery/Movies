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
     Maps an array of PopularMovie response objects to an array of PopularMovieModel domain objects.
     
     - parameter movieResponse: An array of PopularMovie response objects to be mapped.
     
     - returns: An array of PopularMovieModel domain objects.
     */
    static func mapPopularMovieResponseToDomains(
        input movieResponse: [PopularMovie]
    ) -> [PopularMovieModel] {
        return movieResponse.map { result in
            return PopularMovieModel(
                adult: result.adult,
                backdropPath: result.backdropPath,
                genreIDs: result.genreIDs,
                id: result.id,
                originalLanguage: result.originalLanguage,
                originalTitle: result.title,
                overview: result.overview,
                popularity: result.popularity,
                posterPath: result.posterPath,
                releaseDate: result.releaseDate,
                title: result.title,
                video: result.video,
                voteAverage: result.voteAverage,
                voteCount: result.voteCount
            )
        }
    }
    
    
    /**
     Maps an array of UpComingMovie response objects to an array of UpComingMovieModel domain objects.
     
     - parameter movieResponse: An array of UpComingMovie response objects to be mapped.
     
     - returns: An array of UpComingMovieModel domain objects.
     */
    static func mapUpComingMovieResponseToDomains(
        input movieResponse: [UpComingMovie]
    ) -> [UpComingMovieModel] {
        
        /// Map the movie response objects to movie domain objects
        return movieResponse.map { result in
            return UpComingMovieModel(
                adult: result.adult,
                backdropPath: result.backdropPath,
                genreIds: result.genreIds,
                id: result.id,
                originalLanguage: result.originalLanguage,
                originalTitle: result.originalTitle,
                overview: result.overview,
                popularity: result.popularity,
                posterPath: result.posterPath,
                releaseDate: result.releaseDate,
                title: result.title,
                video: result.video,
                voteAverage: result.voteAverage,
                voteCount: result.voteCount
            )
        }
    }
}



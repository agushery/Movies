//
//  DetailMovieModel.swift
//  Movies
//
//  Created by Agus Hery on 13/02/23.
//  Copyright © 2023 Agus Hery. All rights reserved.
//

import Foundation

/**
 The `DetailMovieModel` struct represents a detailed movie model that contains information about a movie, such as its title, overview, release date, vote average, and more.
 */
struct DetailMovieModel {
    /// a `String` optional representing the backdrop path of the movie.
    let backdropPath: String?
    /// an array of `Genres` representing the genres of the movie.
    let genres: [Genres]
    /// a `String` representing the homepage of the movie.
    let homepage: String
    /// an `Int` representing the ID of the movie.
    let id: Int
    /// a `String` representing the original title of the movie.
    let originalTitle: String
    /// a `String` representing the overview of the movie.
    let overview: String
    /// a `Double` representing the popularity of the movie.
    let popularity: Double
    /// a `String` optional representing the poster path of the movie.
    let posterPath: String?
    /// a `String` representing the release date of the movie.
    let releaseDate: String
    /// a `String` representing the title of the movie.
    let title: String
    /// a `Double` representing the average vote score of the movie.
    let voteAverage: Double
    /// an `Integer` representing the total number of votes for the movie.
    let voteCount: Int
}

extension DetailMovieModel {
    /**
        This function maps the `DetailMovieResponse` data to `DetailMovieModel`.

        - Parameter movieResponse: A `DetailMovieResponse` object that contains the movie data to be mapped.

        - Returns: A `DetailMovieModel` object that contains the mapped movie data.

        Usage:
        ```
        let movieResponse = DetailMovieResponse(...)
        let movie = DetailMovieModel.mapDetailMovieResponseToDomainsinput(input: movieResponse)
        ```
        */
    static func mapDetailMovieResponseToDomainsinput(
        input movieResponse: DetailMovieResponse
    ) -> DetailMovieModel {
        return DetailMovieModel(
            backdropPath: movieResponse.backdropPath,
            genres: movieResponse.genres,
            homepage: movieResponse.homepage,
            id: movieResponse.id,
            originalTitle: movieResponse.originalTitle,
            overview: movieResponse.overview,
            popularity: movieResponse.popularity,
            posterPath: movieResponse.posterPath,
            releaseDate: movieResponse.releaseDate,
            title: movieResponse.title,
            voteAverage: movieResponse.voteAverage,
            voteCount: movieResponse.voteCount
        )
    }
}

extension DetailMovieModel {
    /// A static constant `DetailMovieModel` object for dummy data purposes.
    static let dummyData: DetailMovieModel = DetailMovieModel(backdropPath: "", genres: [Genres(id: 1, name: "1")], homepage: "", id: 1, originalTitle: "", overview: "", popularity: 1, posterPath: "", releaseDate: "", title: "", voteAverage: 1, voteCount: 1)
}

//
//  PopularMovieModel.swift
//  Movies
//
//  Created by Agus Hery on 12/02/23.
//  Copyright © 2023 Agus Hery. All rights reserved.
//

import Foundation

/// The `PopularMovieModel` struct represents a popular movie to view
struct PopularMovieModel: Equatable, Identifiable {
    /// A Boolean indicating whether the movie is intended for adults.
    let adult: Bool
    /// The path to the movie's backdrop image.
    let backdropPath: String
    /// An array of genre IDs for the movie.
    let genreIDs: [Int]
    /// The ID of the movie.
    let id: Int
    /// The original language of the movie.
    let originalLanguage: OriginalLanguage
    /// The original title of the movie.
    let originalTitle: String
    /// A brief overview of the movie.
    let overview: String
    /// The movie's popularity score.
    let popularity: Double
    /// The path to the movie's poster image.
    let posterPath: String
    /// The release date of the movie.
    let releaseDate: String
    /// The title of the movie.
    let title: String
    /// A Boolean indicating whether a video is available for the movie.
    let video: Bool
    /// The average rating for the movie.
    let voteAverage: Double
    /// The number of votes for the movie.
    let voteCount: Int
}

extension PopularMovieModel {
    static let dummyData: PopularMovieModel = PopularMovieModel(
        adult: true,
        backdropPath: "",
        genreIDs: [1],
        id: 1,
        originalLanguage: OriginalLanguage.es,
        originalTitle: "title",
        overview: """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
        """,
        popularity: 100,
        posterPath: "https://image.tmdb.org/t/p/w500/bxh5xCCW9Ynfg6EZJWUkc1zqTnr.jpg",
        releaseDate: "20200202",
        title: "title title title title title title",
        video: true,
        voteAverage: 7.5,
        voteCount: 5)
}

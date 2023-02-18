//
//  MovieModel.swift
//  Movies
//
//  Created by Agus Hery on 12/02/23.
//  Copyright © 2023 Agus Hery. All rights reserved.
//

import Foundation

/// The `MovieModel` struct represents a popular movie to view
struct MovieModel: Equatable, Identifiable, Hashable {
    /// The path to the movie's backdrop image.
    let backdropPath: String?
    /// The ID of the movie.
    let id: String
    /// The original title of the movie.
    let originalTitle: String
    /// A brief overview of the movie.
    let overview: String
    /// The movie's popularity score.
    let popularity: Double
    /// The path to the movie's poster image.
    let posterPath: String?
    /// The release date of the movie.
    let releaseDate: String
    /// The title of the movie.
    let title: String
    /// The average rating for the movie.
    let voteAverage: Double
    /// The number of votes for the movie.
    let voteCount: Int
}

extension MovieModel {
    /// A static constant `MovieModel` object for dummy data purposes.
    static let dummyData: MovieModel = MovieModel(
        backdropPath: "",
        id: "",
        originalTitle: "title",
        overview: """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
        """,
        popularity: 100,
        posterPath: "https://image.tmdb.org/t/p/w500/bxh5xCCW9Ynfg6EZJWUkc1zqTnr.jpg",
        releaseDate: "20200202",
        title: "title title title title title title",
        voteAverage: 7.5,
        voteCount: 5)
}

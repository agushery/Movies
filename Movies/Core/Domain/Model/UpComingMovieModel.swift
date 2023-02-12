//
//  UpComingMovieModel.swift
//  Movies
//
//  Created by Agus Hery on 10/02/23.
//

import Foundation

/// Struct representing a upcoming movie model to use case
struct UpComingMovieModel: Equatable, Identifiable  {
    
    /// Indicates if the movie is intended for adults
    let adult: Bool
    
    /// The path of the movie's backdrop image
    let backdropPath: String
    
    /// The genre IDs associated with the movie
    let genreIds: [Int]
    
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
    let posterPath: String
    
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
}

extension UpComingMovieModel {
    static let dummyData: UpComingMovieModel = UpComingMovieModel(
        adult: true,
        backdropPath: "",
        genreIds: [8],
        id: 1,
        originalLanguage: "en",
        originalTitle: "Original Title",
        overview: """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. 
        """,
        popularity: 100.0,
        posterPath: "https://image.tmdb.org/t/p/w500/bxh5xCCW9Ynfg6EZJWUkc1zqTnr.jpg",
        releaseDate: "20220801",
        title: "Title",
        video: true,
        voteAverage: 100.0,
        voteCount: 100)
}

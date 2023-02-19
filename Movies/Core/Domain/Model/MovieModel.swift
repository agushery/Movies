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
        backdropPath: "/xDMIl84Qo5Tsu62c9DGWhmPI67A.jpg",
        id: "529892",
        originalTitle: "Black Panther: Wakanda Forever",
        overview: """
        Queen Ramonda, Shuri, M’Baku, Okoye and the Dora Milaje fight to protect their nation from intervening world powers in the wake of King T’Challa’s death.  As the Wakandans strive to embrace their next chapter, the heroes must band together with the help of War Dog Nakia and Everett Ross and forge a new path for the kingdom of Wakanda.
        """,
        popularity: 4429.317,
        posterPath: "https://image.tmdb.org/t/p/w500/sv1xJUazXeYqALzczSZ3O6nkH75.jpg",
        releaseDate: "2022-11-09",
        title: "Black Panther: Wakanda Forever",
        voteAverage: 7.5,
        voteCount: 3245)
}

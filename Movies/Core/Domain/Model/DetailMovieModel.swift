//
//  DetailMovieModel.swift
//  Movies
//
//  Created by Agus Hery on 13/02/23.
//  Copyright © 2023 Agus Hery. All rights reserved.
//

import Foundation

struct DetailMovieModel {
    let backdropPath: String?
    let genres: [Genres]
    let homepage: String
    let id: Int
    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: String?
    let releaseDate: String
    let title: String
    let voteAverage: Double
    let voteCount: Int
}

extension DetailMovieModel {
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
    static let dummyData: DetailMovieModel = DetailMovieModel(backdropPath: "", genres: [Genres(id: 1, name: "1")], homepage: "", id: 1, originalTitle: "", overview: "", popularity: 1, posterPath: "", releaseDate: "", title: "", voteAverage: 1, voteCount: 1)
}

//
//  DetailMovieModel.swift
//  Movies
//
//  Created by Agus Hery on 13/02/23.
//  Copyright © 2023 Agus Hery. All rights reserved.
//

import Foundation

struct DetailMovieModel {
    let adult: Bool
    let backdropPath: String?
    let budget: Int
    let genres: [Genres]
    let homepage: String
    let id: Int
    let imdbId: String
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: String?
    let productionCompanies: [ProductionCompanys]
    let productionCountries: [ProductionCountrys]
    let releaseDate: String
    let revenue: Int
    let runtime: Int
    let spokenLanguages: [SpokenLanguages]
    let status: String
    let tagline: String
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
}

extension DetailMovieModel {
    static func mapDetailMovieResponseToDomainsinput(
        input movieResponse: DetailMovieResponse
    ) -> DetailMovieModel {
        return DetailMovieModel(
            adult: movieResponse.adult,
            backdropPath: movieResponse.backdropPath,
            budget: movieResponse.budget,
            genres: movieResponse.genres,
            homepage: movieResponse.homepage,
            id: movieResponse.id,
            imdbId: movieResponse.imdbId,
            originalLanguage: movieResponse.originalLanguage,
            originalTitle: movieResponse.originalTitle,
            overview: movieResponse.overview,
            popularity: movieResponse.popularity,
            posterPath: movieResponse.posterPath,
            productionCompanies: movieResponse.productionCompanies,
            productionCountries: movieResponse.productionCountries,
            releaseDate: movieResponse.releaseDate,
            revenue: movieResponse.revenue,
            runtime: movieResponse.runtime,
            spokenLanguages: movieResponse.spokenLanguages,
            status: movieResponse.status,
            tagline: movieResponse.tagline,
            title: movieResponse.title,
            video: movieResponse.video,
            voteAverage: movieResponse.voteAverage,
            voteCount: movieResponse.voteCount
        )
    }
}

extension DetailMovieModel {
    static let dummyData: DetailMovieModel = DetailMovieModel(adult: true, backdropPath: "", budget: 1, genres: [Genres(id: 1, name: "1")], homepage: "", id: 1, imdbId: "", originalLanguage: "", originalTitle: "", overview: "", popularity: 1, posterPath: "", productionCompanies: [ProductionCompanys(id: 1, logoPath: "", name: "", originCountry: "")], productionCountries: [ProductionCountrys(iso31661: "", name: "")], releaseDate: "", revenue: 1, runtime: 1, spokenLanguages: [SpokenLanguages(iso6391: "", name: "")], status: "", tagline: "", title: "", video: true, voteAverage: 1, voteCount: 1)
}

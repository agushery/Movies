//
//  DetailMovieResponse.swift
//  Movies
//
//  Created by Agus Hery on 13/02/23.
//  Copyright © 2023 Agus Hery. All rights reserved.
//

import Foundation

// MARK: - DetailMovieResponse
struct DetailMovieResponse: Decodable {
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
    
    private enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case budget
        case genres
        case homepage
        case id
        case imdbId = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue
        case runtime
        case spokenLanguages = "spoken_languages"
        case status
        case tagline
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

struct Genres: Decodable, Identifiable {
    let id: Int
    let name: String
}

struct ProductionCompanys: Decodable {
    let id: Int
    let logoPath: String?
    let name: String
    let originCountry: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}

struct ProductionCountrys: Decodable {
    let iso31661: String
    let name: String
    
    private enum CodingKeys: String, CodingKey {
        case iso31661 = "iso_3166_1"
        case name
    }
}

struct SpokenLanguages: Decodable {
    let iso6391: String
    let name: String
    
    private enum CodingKeys: String, CodingKey {
        case iso6391 = "iso_639_1"
        case name
    }
}

//
//  UpComingMovieEntity.swift
//  Movies
//
//  Created by Agus Hery on 17/02/23.
//  Copyright © 2023 Agus Hery. All rights reserved.
//

import Foundation
import RealmSwift

class UpComingMovieEntity: Object {
    /// The path of the movie's backdrop image
    @objc dynamic var backdropPath: String? = nil
    
    /// The movie's unique identifier
    @objc dynamic var id: String = ""
    
    /// The original title of the movie
    @objc dynamic var originalTitle: String = ""
    
    /// A brief overview of the movie
    @objc dynamic var overview: String = ""
    
    /// The movie's popularity score
    @objc dynamic var popularity: Double = 0.0
    
    /// The path of the movie's poster image
    @objc dynamic var posterPath: String? = nil
    
    /// The release date of the movie
    @objc dynamic var releaseDate: String = ""
    
    /// The title of the movie
    @objc dynamic var title: String = ""
    
    /// The average rating for the movie
    @objc dynamic var voteAverage: Double = 0.0
    
    /// The number of votes for the movie
    @objc dynamic var voteCount: Int = 0
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

extension UpComingMovieEntity {
    
    static func toPopularEntity(from movies: [MovieResponse]) -> [UpComingMovieEntity] {
        return movies.map { result in
            let entity = UpComingMovieEntity()
            entity.id = String(result.id)
            entity.backdropPath = result.backdropPath
            entity.originalTitle = result.originalTitle
            entity.overview = result.overview
            entity.popularity = result.popularity
            entity.posterPath = result.posterPath
            entity.releaseDate = result.releaseDate
            entity.title = result.title
            entity.voteAverage = result.voteAverage
            entity.voteCount = result.voteCount
            return entity
        }
    }
    
    static func toPopularMovieModel(from entity: [UpComingMovieEntity]) -> [MovieModel] {
        return entity.map { result in
            return MovieModel(
                backdropPath: result.backdropPath,
                id: result.id,
                originalTitle: result.originalTitle,
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

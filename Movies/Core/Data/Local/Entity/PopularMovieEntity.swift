//
//  PopularMovieEntity.swift
//  Movies
//
//  Created by Agus Hery on 10/02/23.
//  Copyright © 2023 Agus Hery. All rights reserved.
//

import Foundation
import RealmSwift

class PopularMovieEntity: Object {
    /// Indicates if the movie is intended for adults
    @objc dynamic var adult: Bool = false
    
    /// The path of the movie's backdrop image
    @objc dynamic var backdropPath: String = ""
    
    /// The genre IDs associated with the movie
    @objc dynamic var genreIds: [Int] = []
    
    /// The movie's unique identifier
    @objc dynamic var id: String = ""
    
    /// The original language of the movie
    @objc dynamic var originalLanguage: String = ""
    
    /// The original title of the movie
    @objc dynamic var originalTitle: String = ""
    
    /// A brief overview of the movie
    @objc dynamic var overview: String = ""
    
    /// The movie's popularity score
    @objc dynamic var popularity: Double = 0.0
    
    /// The path of the movie's poster image
    @objc dynamic var posterPath: String = ""
    
    /// The release date of the movie
    @objc dynamic var releaseDate: String = ""
    
    /// The title of the movie
    @objc dynamic var title: String = ""
    
    /// Indicates if the movie has a video
    @objc dynamic var video: Bool = false
    
    /// The average rating for the movie
    @objc dynamic var voteAverage: Double = 0.0
    
    /// The number of votes for the movie
    @objc dynamic var voteCount: Int = 0
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

extension PopularMovieEntity {
    
    func toPopularMovieModel() -> MovieModel {
        return MovieModel(
            adult: self.adult,
            backdropPath: self.backdropPath,
            genreIDs: self.genreIds,
            id: self.id,
            originalLanguage: self.originalLanguage,
            originalTitle: self.originalTitle,
            overview: self.overview,
            popularity: self.popularity,
            posterPath: self.posterPath,
            releaseDate: self.releaseDate,
            title: self.title,
            video: self.video,
            voteAverage: self.voteAverage,
            voteCount: self.voteCount
        )
    }
    
}

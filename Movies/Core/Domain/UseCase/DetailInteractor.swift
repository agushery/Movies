//
//  DetailInteractor.swift
//  Movies
//
//  Created by Agus Hery on 13/02/23.
//  Copyright © 2023 Agus Hery. All rights reserved.
//

import Foundation

/// This protocol defines the requirements for a use case that fetches movie details and videos.
protocol DetailUseCase {
    
    /// Fetches the detail information of a movie with a given ID.
    func getDetailMovie(completion: @escaping (Result<DetailMovieModel, Error>) -> Void, idMovie: String)
    
    /// Fetches the videos of a movie with a given ID.
    func getVideosMovie(completion: @escaping (Result<[VideoModel], Error>) -> Void, idMovie: String)
}

/// This interactor implements the DetailUseCase protocol and fetches movie details and videos using a movie repository.
class DetailInteractor: DetailUseCase {
    
    /// The repository that provides access to the movie data.
    private let repository: MovieRepositoryProtocol
    
    /// Initializes the interactor with a repository.
    required init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }
    
    /// Implements the getDetailMovie method of the DetailUseCase protocol by calling the corresponding method of the repository.
    func getDetailMovie(
        completion: @escaping (Result<DetailMovieModel, Error>) -> Void,
        idMovie: String
    ) {
        repository.getDetailMovie(completion: { result in
            completion(result)
        }, idMovie: idMovie)
    }
    
    /// Implements the getVideosMovie method of the DetailUseCase protocol by calling the corresponding method of the repository.
    func getVideosMovie(
        completion: @escaping (Result<[VideoModel], Error>) -> Void,
        idMovie: String
    ) {
        repository.getVideosMovie(completion: { result in
            completion(result)
        }, idMovie: idMovie)
    }
}


//
//  DetailInteractor.swift
//  Movies
//
//  Created by Agus Hery on 13/02/23.
//  Copyright © 2023 Agus Hery. All rights reserved.
//

import Foundation

protocol DetailUseCase {
    
    func getDetailMovie(completion: @escaping (Result<DetailMovieModel, Error>) -> Void, idMovie: String)
    
    func getVideosMovie(completion: @escaping (Result<[VideoModel], Error>) -> Void, idMovie: String)
}

class DetailInteractor: DetailUseCase {
    
    private let repository: MovieRepositoryProtocol
    
    required init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }
    
    func getDetailMovie(
        completion: @escaping (Result<DetailMovieModel, Error>) -> Void,
        idMovie: String
    ) {
        repository.getDetailMovie(completion: { result in
            completion(result)
        }, idMovie: idMovie)
    }
    
    func getVideosMovie(
        completion: @escaping (Result<[VideoModel], Error>) -> Void,
        idMovie: String) {
            repository.getVideosMovie(completion: { result in
                completion(result)
            }, idMovie: idMovie)
    }
}

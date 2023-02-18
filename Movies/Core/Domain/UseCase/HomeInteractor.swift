//
//  HomeInteractor.swift
//  Movies
//
//  Created by Agus Hery on 11/02/23.
//  Copyright © 2023 Agus Hery. All rights reserved.
//

import Foundation
import RxSwift

protocol HomeUseCase {
    
    func getPopularMovies() -> Observable<[MovieModel]>
    
    func getUpcomingMovies(completion: @escaping (Result<[MovieModel], Error>) -> Void)
    
    func searchMovies(completion: @escaping (Result<[MovieModel], Error>) -> Void, query: String)
}

class HomeInteractor: HomeUseCase {
    
    private let repository: MovieRepositoryProtocol
    
    required init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }
    
    func getPopularMovies() -> Observable<[MovieModel]> {
        return repository.getPopularMovies()
    }
    
    func getUpcomingMovies(
        completion: @escaping (Result<[MovieModel], Error>) -> Void
    ) {
        repository.getUpcomingMovies { result in
            completion(result)
        }
    }
    
    func searchMovies(
        completion: @escaping (Result<[MovieModel], Error>) -> Void,
        query: String) {
            repository.searchMovies(completion: { result in
                completion(result)
            }, query: query)
    }
}

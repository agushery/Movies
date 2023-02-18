//
//  HomeInteractor.swift
//  Movies
//
//  Created by Agus Hery on 11/02/23.
//  Copyright © 2023 Agus Hery. All rights reserved.
//

import Foundation
import RxSwift

// The `HomeUseCase` protocol defines the requirements for a use case that deals with movie-related functionalities.
protocol HomeUseCase {
    
    // Retrieves popular movies as an Observable of an array of `MovieModel`.
    func getPopularMovies() -> Observable<[MovieModel]>
    
    // Retrieves upcoming movies as a completion block of a `Result` type array of `MovieModel`.
    func getUpcomingMovies(completion: @escaping (Result<[MovieModel], Error>) -> Void)
    
    // Searches movies using a query string and returns a completion block of a `Result` type array of `MovieModel`.
    func searchMovies(completion: @escaping (Result<[MovieModel], Error>) -> Void, query: String)
}

// The `HomeInteractor` class is a concrete implementation of the `HomeUseCase` protocol. It implements functionalities related to movie data.
class HomeInteractor: HomeUseCase {
    
    // The `repository` instance variable is an object that conforms to `MovieRepositoryProtocol`, which provides access to movie data.
    private let repository: MovieRepositoryProtocol
    
    // Initializes the interactor with a `MovieRepositoryProtocol` object.
    required init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }
    
    // Retrieves popular movies as an Observable of an array of `MovieModel`.
    func getPopularMovies() -> Observable<[MovieModel]> {
        return repository.getPopularMovies()
    }
    
    // Retrieves upcoming movies as a completion block of a `Result` type array of `MovieModel`.
    func getUpcomingMovies(completion: @escaping (Result<[MovieModel], Error>) -> Void) {
        repository.getUpcomingMovies { result in
            completion(result)
        }
    }
    
    // Searches movies using a query string and returns a completion block of a `Result` type array of `MovieModel`.
    func searchMovies(completion: @escaping (Result<[MovieModel], Error>) -> Void, query: String) {
        repository.searchMovies(completion: { result in
            completion(result)
        }, query: query)
    }
}


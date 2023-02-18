//
//  MovieRepository.swift
//  Movies
//
//  Created by Agus Hery on 10/02/23.
//  Copyright © 2023 Agus Hery. All rights reserved.
//

import Foundation
import RxSwift

/**
A protocol that defines methods to retrieve movie data from different sources.
*/
protocol MovieRepositoryProtocol {
    
    /**
     Returns an observable stream of popular movies.
     
     - Returns: An observable stream of `[MovieModel]` objects.
     */
    func getPopularMovies() -> Observable<[MovieModel]>

    /**
     Retrieves upcoming movies from a remote data source.
     
     - Parameter completion: A completion handler that returns a result of `[MovieModel]` or `Error`.
     */
    func getUpcomingMovies(completion: @escaping (Result<[MovieModel], Error>) -> Void)

    /**
     Retrieves detailed information for a specific movie.
     
     - Parameters:
        - completion: A completion handler that returns a result of `DetailMovieModel` or `Error`.
        - idMovie: The identifier of the movie to retrieve.
     */
    func getDetailMovie(completion: @escaping (Result<DetailMovieModel, Error>) -> Void, idMovie: String)

    /**
     Retrieves video information for a specific movie.
     
     - Parameters:
        - completion: A completion handler that returns a result of `[VideoModel]` or `Error`.
        - idMovie: The identifier of the movie to retrieve videos for.
     */
    func getVideosMovie(completion: @escaping (Result<[VideoModel], Error>) -> Void, idMovie: String)

    /**
     Searches for movies using a query string.
     
     - Parameters:
        - completion: A completion handler that returns a result of `[MovieModel]` or `Error`.
        - query: The search query to use.
     */
    func searchMovies(completion: @escaping (Result<[MovieModel], Error>) -> Void, query: String)

}

/**
A concrete implementation of MovieRepositoryProtocol that retrieves movie data from local and remote data sources.
* Parameters:
*    locale: An instance of `LocalDataSource` to retrieve data from a local data source.
*    remote: An instance of `RemoteDataSource` to retrieve data from a remote data source.
*/
final class MovieRepository: NSObject {
    
    /// A closure that creates an instance of `MovieRepository`.
    typealias MovieInstance = (LocalDataSource ,RemoteDataSource) -> MovieRepository

    fileprivate let locale: LocalDataSource
    fileprivate let remote: RemoteDataSource
    
    /// Initializes an instance of `MovieRepository`
    private init(locale: LocalDataSource, remote: RemoteDataSource) {
        self.locale = locale
        self.remote = remote
    }

    /**
     Returns a singleton instance of `MovieRepository`.
     
     - Parameters:
        - localeRepo: An instance of `LocalDataSource` to retrieve data from a local data source.
        - remoteRepo: An instance of `RemoteDataSource` to retrieve data from a remote data source.
     
     - Returns: A singleton instance of `MovieRepository`.
     */
    static let sharedInstance: MovieInstance = { localeRepo, remoteRepo in
        return MovieRepository(locale: localeRepo, remote: remoteRepo)
    }

}

extension MovieRepository: MovieRepositoryProtocol {
    
    /// Returns an Observable containing a list of popular movies. If the list is not available locally, it is fetched from the remote data source.
    /// If the remote data source fails or returns an empty list, an empty list is returned.
    /// The list is transformed from the entity layer to the model layer before being returned.
    func getPopularMovies() -> Observable<[MovieModel]> {
        return locale.getPopularMovies()
            .map { PopularMovieEntity.toPopularMovieModel(from: $0) }
            .filter { !$0.isEmpty }
            .ifEmpty(switchTo: self.remote.getPopularMovies()
                .map { PopularMovieEntity.toPopularEntity(from: $0) }
                .flatMap { self.locale.addPopularMovies(from: $0) }
                .filter { $0 }
                .flatMap({ _ in
                    self.locale.getPopularMovies()
                        .map { PopularMovieEntity.toPopularMovieModel(from: $0) }
                })
            )
    }
    
    /**
    This function retrieves upcoming movies either from the local data source or from the remote data source if it is not available locally.
    -   Parameter completion: A closure that accepts a Result object, which contains either an array of MovieModel objects or an error if the operation fails.
    -   Returns: Void
    -   Note: If the upcoming movies are available locally, the function retrieves them from the local data source. If the upcoming movies are not available locally, the function retrieves them from the remote data source and adds them to the local data source for future use.
    */
    func getUpcomingMovies(
        completion: @escaping (Result<[MovieModel], Error>) -> Void
    ) {
        // Get upcoming movies from local data source
        self.locale.getUpComingMovies { localeResponses in
            switch localeResponses {
            case .success(let movieEntity):
                // Map entity response to model
                let movieList = UpComingMovieEntity.toPopularMovieModel(from: movieEntity)
                
                // If local data source has no data, fetch from remote data source
                if movieList.isEmpty {
                    self.remote.getUpcomingMovies { remoteResponses in
                        switch remoteResponses {
                        case .success(let movieResponses):
                            // Map remote response to entity
                            let movieEntity = UpComingMovieEntity.toPopularEntity(from: movieResponses)
                            
                            // Add fetched data to local data source
                            self.locale.addUpcomingMovies(from: movieEntity) { addState in
                                switch addState {
                                case .success(let resultFromAdd):
                                    // If adding to local data source is successful,
                                    // fetch data again from local data source and return the result
                                    if resultFromAdd {
                                        self.locale.getUpComingMovies { localeResponses in
                                            switch localeResponses {
                                            case .success(let movieEntity):
                                                let resultList = UpComingMovieEntity.toPopularMovieModel(from: movieEntity)
                                                completion(.success(resultList))
                                            case .failure(let error):
                                                completion(.failure(error))
                                            }
                                        }
                                    }
                                case .failure(let error):
                                    completion(.failure(error))
                                }
                            }
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
                } else {
                    // Return the result from local data source
                    completion(.success(movieList))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    
    /**
    Calls the remote data source's getDetailMovie method to retrieve detailed information about a specific movie using the given movie ID, then maps the response to a DetailMovieModel object before passing it to the completion handler.
     
    -   Parameter completion: The closure to call once the operation is complete. The closure takes a Result object containing either the successfully mapped DetailMovieModel or an Error.
    -   Parameter idMovie: The ID of the movie to retrieve information for..
    */
    func getDetailMovie(
        completion: @escaping (Result<DetailMovieModel, Error>) -> Void,
        idMovie: String
    ) {
        self.remote.getDetailMovie(result: { remoteResponse in
            switch remoteResponse {
            case .success(let movieResponse):
                let resultList = DetailMovieModel.mapDetailMovieResponseToDomainsinput(input: movieResponse)
                completion(.success(resultList))
            case .failure(let error):
                completion(.failure(error))
            }
        }, idMovie: idMovie)
    }
    
    /**
     Fetches the videos for a given movie id from the remote data source.
     
     - Parameter completion: A closure with a Result enum that either contains an array of VideoModel objects on success, or an error on failure.
     - Parameter idMovie: The id of the movie to fetch the videos for.
     */
    func getVideosMovie(
        completion: @escaping (Result<[VideoModel], Error>) -> Void,
        idMovie: String
    ) {
        self.remote.getVideoMovie(result: { remoteResponse in
            switch remoteResponse {
            case .success(let success):
                let resultList = VideoModel.mapVideoResponseToDomain(input: success)
                completion(.success(resultList))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }, idMovie: idMovie)
    }

    /**
     Searches for movies with a given query string from the remote data source.
     
     - Parameter completion: A closure with a Result enum that either contains an array of MovieModel objects on success, or an error on failure.
     - Parameter query: The query string to search for movies with.
     */
    func searchMovies(
        completion: @escaping (Result<[MovieModel], Error>) -> Void,
        query: String
    ) {
        self.remote.searchMovies(result: { remoteResponse in
            switch remoteResponse {
            case .success(let success):
                let resultList = MovieMapper.mapMovieResponseToDomains(input: success)
                completion(.success(resultList))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }, query: query)
    }

}

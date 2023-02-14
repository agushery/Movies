//
//  MovieRepository.swift
//  Movies
//
//  Created by Agus Hery on 10/02/23.
//  Copyright © 2023 Agus Hery. All rights reserved.
//

import Foundation

protocol MovieRepositoryProtocol {
    
    func getPopularMovies(completion: @escaping (Result<[MovieModel], Error>) -> Void)
    
    func getUpcomingMovies(completion: @escaping (Result<[MovieModel], Error>) -> Void)
    
    func getDetailMovie(completion: @escaping (Result<DetailMovieModel, Error>) -> Void, idMovie: String)
    
    func getVideosMovie(completion: @escaping (Result<[VideoModel], Error>) -> Void, idMovie: String)
    
    func searchMovies(completion: @escaping (Result<[MovieModel], Error>) -> Void, query: String)
}

final class MovieRepository: NSObject {
    
    typealias MovieInstance = (RemoteDataSource) -> MovieRepository
    
    fileprivate let remote: RemoteDataSource
    
    private init(remote: RemoteDataSource) {
        self.remote = remote
    }
    
    static let sharedInstance: MovieInstance = { remoteRepo in
        return MovieRepository(remote: remoteRepo)
    }
}

extension MovieRepository: MovieRepositoryProtocol {
    
    func getPopularMovies(
        completion: @escaping (Result<[MovieModel], Error>) -> Void
    ) {
        self.remote.getPopularMovies { remoteResponse in
            switch remoteResponse {
            case .success(let movieResponse):
                let resultList = MovieMapper.mapMovieResponseToDomains(input: movieResponse)
                completion(.success(resultList))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getUpcomingMovies(
        completion: @escaping (Result<[MovieModel], Error>) -> Void
    ) {
        self.remote.getUpcomingMovies { remoteResponse in
            switch remoteResponse {
            case .success(let movieResponse):
                let resultList = MovieMapper.mapMovieResponseToDomains(input: movieResponse)
                completion(.success(resultList))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
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
    
    func getVideosMovie(
        completion: @escaping (Result<[VideoModel], Error>) -> Void,
        idMovie: String) {
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

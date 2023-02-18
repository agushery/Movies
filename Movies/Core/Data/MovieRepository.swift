//
//  MovieRepository.swift
//  Movies
//
//  Created by Agus Hery on 10/02/23.
//  Copyright © 2023 Agus Hery. All rights reserved.
//

import Foundation
import RxSwift

protocol MovieRepositoryProtocol {
    
    func getPopularMovies() -> Observable<[MovieModel]>
    
    func getUpcomingMovies(completion: @escaping (Result<[MovieModel], Error>) -> Void)
    
    func getDetailMovie(completion: @escaping (Result<DetailMovieModel, Error>) -> Void, idMovie: String)
    
    func getVideosMovie(completion: @escaping (Result<[VideoModel], Error>) -> Void, idMovie: String)
    
    func searchMovies(completion: @escaping (Result<[MovieModel], Error>) -> Void, query: String)
}

final class MovieRepository: NSObject {
    
    typealias MovieInstance = (LocalDataSource ,RemoteDataSource) -> MovieRepository
    
    fileprivate let locale: LocalDataSource
    fileprivate let remote: RemoteDataSource
    
    private init(locale: LocalDataSource, remote: RemoteDataSource) {
        self.locale = locale
        self.remote = remote
    }
    
    static let sharedInstance: MovieInstance = { localeRepo, remoteRepo in
        return MovieRepository(locale: localeRepo, remote: remoteRepo)
    }
}

extension MovieRepository: MovieRepositoryProtocol {
    
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
    
    func getUpcomingMovies(
        completion: @escaping (Result<[MovieModel], Error>) -> Void
    ) {
        self.locale.getUpComingMovies { localeResponses in
          switch localeResponses {
          case .success(let movieEntity):
              let movieList = UpComingMovieEntity.toPopularMovieModel(from: movieEntity)
            if movieList.isEmpty {
              self.remote.getUpcomingMovies { remoteResponses in
                switch remoteResponses {
                case .success(let movieResponses):
                    let movieEntity = UpComingMovieEntity.toPopularEntity(from: movieResponses)
                  self.locale.addUpcomingMovies(from: movieEntity) { addState in
                    switch addState {
                    case .success(let resultFromAdd):
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
              completion(.success(movieList))
            }
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

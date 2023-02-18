//
//  RemoteDataSource.swift
//  Movies
//
//  Created by Agus Hery on 10/02/23.
//  Copyright © 2023 Agus Hery. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

/**
    The `RemoteDataSource` protocol defines methods to retrieve movie data from a remote data source.
*/
protocol RemoteDataSource: AnyObject {
    /**
     Retrieve popular movies data from the remote data source.
     
     - Returns: An `Observable` sequence of `[MovieResponse]` objects.
     */
    func getPopularMovies() -> Observable<[MovieResponse]>

    /**
     Retrieve upcoming movies data from the remote data source.
     
     - Parameters:
        - result: A completion block that will be called with a `Result` object containing an array of `MovieResponse` objects or a `URLError` if an error occurred while retrieving data.
     */
    func getUpcomingMovies(result: @escaping (Result<[MovieResponse], URLError>) -> Void)

    /**
     Retrieve detail movie data from the remote data source.
     
     - Parameters:
        - result: A completion block that will be called with a `Result` object containing a `DetailMovieResponse` object or a `URLError` if an error occurred while retrieving data.
        - idMovie: The ID of the movie to retrieve.
     */
    func getDetailMovie(result: @escaping (Result<DetailMovieResponse, URLError>) -> Void, idMovie: String)

    /**
     Retrieve video data for a movie from the remote data source.
     
     - Parameters:
        - result: A completion block that will be called with a `Result` object containing an array of `Video` objects or a `URLError` if an error occurred while retrieving data.
        - idMovie: The ID of the movie to retrieve video data for.
     */
    func getVideoMovie(result: @escaping (Result<[Video], URLError>) -> Void, idMovie: String )

    /**
     Search for movies in the remote data source based on a query.
     
     - Parameters:
        - result: A completion block that will be called with a `Result` object containing an array of `MovieResponse` objects or a `URLError` if an error occurred while retrieving data.
        - query: The query to search for movies with.
     */
    func searchMovies(result: @escaping (Result<[MovieResponse], URLError>) -> Void, query: String)

}

/**
    The `RemoteDataSourceImpl` class is a concrete implementation of the `RemoteDataSource` protocol that retrieves movie data from a remote server.
*/
final class RemoteDataSourceImpl: NSObject {
    
    private override init() { }

    /// The shared instance of `RemoteDataSourceImpl`.
    static let sharedInstance: RemoteDataSource = RemoteDataSourceImpl()
    
}

extension RemoteDataSourceImpl: RemoteDataSource {
    /**
         Fetches popular movies from the API
         
         - Returns: An observable of an array of `MovieResponse` objects.
    */
    func getPopularMovies() -> Observable<[MovieResponse]> {
        return Observable<[MovieResponse]>.create { observer in
            if let url = URL(string: EndPoints.Gets.popular.url) {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: MoviesResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            observer.onNext(value.results)
                            observer.onCompleted()
                        case .failure(let error):
                            observer.onError(error)
                        }
                    }
            }
            return Disposables.create()
        }
    }

    /**
         Fetches upcoming movies from the API
         
         - Parameters:
            - result: A closure that returns a `Result` object containing an array of `MovieResponse` objects or a `URLError` object.
    */
    func getUpcomingMovies(
        result: @escaping (Result<[MovieResponse], URLError>) -> Void
    ){
        guard let url = URL(string: EndPoints.Gets.upcoming.url) else {
            print("URL not found!")
            return
        }
        
        AF.request(url)
            .validate()
            .responseDecodable(of: MoviesResponse.self) { response in
                switch response.result {
                case .success(let value):
                    result(.success(value.results))
                case .failure:
                    result(.failure(.invalidResponse))
                }
            }
    }
    
    /**
         Fetches the detail of a movie from the API
         
         - Parameters:
            - result: A closure that returns a `Result` object containing a `DetailMovieResponse` object or a `URLError` object.
            - idMovie: The ID of the movie to fetch the detail.
    */
    func getDetailMovie(
        result: @escaping (Result<DetailMovieResponse, URLError>) -> Void,
        idMovie: String
    ) {
        guard let url = URL(string: EndPoints.Gets.detail(id: idMovie).url) else {
            print("URL not found!")
            return
        }
        
        AF.request(url)
            .validate()
            .responseDecodable(of: DetailMovieResponse.self) { response in
                switch response.result {
                case .success(let value):
                    result(.success(value))
                case .failure:
                    result(.failure(.invalidResponse))
                }
            }
    }
    
    /**
         Fetches the videos of a movie from the API
         
         - Parameters:
            - result: A closure that returns a `Result` object containing an array of `Video` objects or a `URLError` object.
            - idMovie: The ID of the movie to fetch the videos.
    */
    func getVideoMovie(
        result: @escaping (Result<[Video], URLError>) -> Void,
        idMovie: String
    ) {
        guard let url = URL(string: EndPoints.Gets.video(id: idMovie).url) else {
            print("URL not found!")
            return
        }
        
        AF.request(url)
            .validate()
            .responseDecodable(of: VideoResponse.self) { response in
                switch response.result {
                case .success(let value):
                    result(.success(value.results))
                case .failure:
                    result(.failure(.invalidResponse))
                }
            }
    }
    
    /**
     Searches for movies that match a given query
     
     - Parameters:
        - result: A closure that returns an array of `MovieResponse` or an error of type `URLError`
        - query: The query to search for movies
     */
    func searchMovies(
        result: @escaping (Result<[MovieResponse], URLError>) -> Void,
        query: String
    ) {
        let newQuery = query.replacingOccurrences(of: " ", with: "%20")
        guard let url = URL(string: EndPoints.Gets.search(query: newQuery).url) else {
            print("URL not found!")
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                result(.failure(.addressUnReseachable(url)))
            } else if let data = data,
                      let response = response as? HTTPURLResponse,
                      response.statusCode == 200 {
                let decoder = JSONDecoder()
                do {
                    let resultList = try decoder.decode(MoviesResponse.self, from: data).results
                    result(.success(resultList))
                } catch {
                    result(.failure(.invalidResponse))
                }
            }
        }
        task.resume()
    }
}

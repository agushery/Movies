//
//  RemoteDataSource.swift
//  Movies
//
//  Created by Agus Hery on 10/02/23.
//  Copyright © 2023 Agus Hery. All rights reserved.
//

import Foundation

protocol RemoteDataSource: AnyObject {
    func getPopularMovies(result: @escaping (Result<[PopularMovie], URLError>) -> Void)
    func getUpcomingMovies(result: @escaping (Result<[UpComingMovie], URLError>) -> Void)
}

final class RemoteDataSourceImpl: NSObject {
    
    private override init() { }
    
    static let sharedInstance: RemoteDataSource = RemoteDataSourceImpl()
    
}

extension RemoteDataSourceImpl: RemoteDataSource {
    
    func getPopularMovies(
        result: @escaping (Result<[PopularMovie], URLError>) -> Void
    ){
        guard let url = URL(string: EndPoints.Gets.popular.url) else {
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
                    let movies = try decoder.decode(PopularMovieResponse.self, from: data).results
                    result(.success(movies))
                } catch {
                    result(.failure(.invalidResponse))
                }
            }
        }
        task.resume()
    }
    
    func getUpcomingMovies(
        result: @escaping (Result<[UpComingMovie], URLError>) -> Void
    ){
        guard let url = URL(string: EndPoints.Gets.upcoming.url) else {
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
                    let movies = try decoder.decode(UpComingMoviesResponse.self, from: data).results
                    result(.success(movies))
                } catch {
                    result(.failure(.invalidResponse))
                }
            }
        }
        task.resume()
    }
    
}
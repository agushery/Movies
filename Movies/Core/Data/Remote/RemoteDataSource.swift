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

protocol RemoteDataSource: AnyObject {
    func getPopularMovies() -> Observable<[MovieResponse]>
    func getUpcomingMovies(result: @escaping (Result<[MovieResponse], URLError>) -> Void)
    func getDetailMovie(result: @escaping (Result<DetailMovieResponse, URLError>) -> Void, idMovie: String)
    func getVideoMovie(result: @escaping (Result<[Video], URLError>) -> Void, idMovie: String )
    func searchMovies(result: @escaping (Result<[MovieResponse], URLError>) -> Void, query: String)
}

final class RemoteDataSourceImpl: NSObject {
    
    private override init() { }
    
    static let sharedInstance: RemoteDataSource = RemoteDataSourceImpl()
    
}

extension RemoteDataSourceImpl: RemoteDataSource {
    
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

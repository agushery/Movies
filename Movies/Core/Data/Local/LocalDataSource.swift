//
//  LocalDataSource.swift
//  Movies
//
//  Created by Agus Hery on 12/02/23.
//  Copyright © 2023 Agus Hery. All rights reserved.
//

import Foundation
import RealmSwift

protocol LocalDataSource: AnyObject {
    
    func getPopularMovies(result: @escaping (Result<[PopularMovieEntity], DatabaseError>) -> Void)
    
    func addPopularMovies(from movies: [PopularMovieEntity],
                          result: @escaping (Result<Bool, DatabaseError>) -> Void)
    
    func getUpComingMovies(result: @escaping (Result<[UpComingMovieEntity], DatabaseError>) -> Void)
    
    func addUpcomingMovies(from movies: [UpComingMovieEntity],
                           result: @escaping (Result<Bool, DatabaseError>) -> Void)
    
}

final class LocalDataSourceImpl: NSObject {
    
    private let realm: Realm?
    
    private init(realm: Realm?) {
        self.realm = realm
    }
    
    static let sharedInstance: (Realm?) -> LocalDataSource = { realmDatabase in
        return LocalDataSourceImpl(realm: realmDatabase)
    }
    
}

extension LocalDataSourceImpl: LocalDataSource {
    func getUpComingMovies(
        result: @escaping (Result<[UpComingMovieEntity], DatabaseError>) -> Void
    ) {
        if let realm = realm {
            DispatchQueue.main.async {
                let movies: Results<UpComingMovieEntity> = {
                    realm.objects(UpComingMovieEntity.self)
                }()
                result(.success(movies.toArray(ofType: UpComingMovieEntity.self)))
            }
        } else {
            result(.failure(.invalidInstance))
        }
    }
    
    func addUpcomingMovies(
        from movies: [UpComingMovieEntity],
        result: @escaping (Result<Bool, DatabaseError>) -> Void
    ) {
        if let realm = realm {
            DispatchQueue.main.async {
                do {
                    try realm.write {
                        for movie in movies {
                            realm.add(movie, update: .all)
                        }
                    }
                    result(.success(true))
                } catch {
                    result(.failure(.requestFailed))
                }
            }
        } else {
            result(.failure(.invalidInstance))
        }
    }
    
    
    func getPopularMovies(
        result: @escaping (Result<[PopularMovieEntity], DatabaseError>) -> Void
    ) {
        if let realm = realm {
            DispatchQueue.main.async {
                let movies: Results<PopularMovieEntity> = {
                    realm.objects(PopularMovieEntity.self)
                }()
                result(.success(movies.toArray(ofType: PopularMovieEntity.self)))
            }
        } else {
            result(.failure(.invalidInstance))
        }
    }
    
    
    func addPopularMovies(from movies: [PopularMovieEntity], result: @escaping (Result<Bool, DatabaseError>) -> Void) {
        if let realm = realm {
            DispatchQueue.main.async {
                do {
                    try realm.write {
                        for movie in movies {
                            realm.add(movie, update: .all)
                        }
                    }
                    result(.success(true))
                } catch {
                    result(.failure(.requestFailed))
                }
            }
        } else {
            result(.failure(.invalidInstance))
        }
    }
    
    
}

extension Results {

  func toArray<T>(ofType: T.Type) -> [T] {
    var array = [T]()
    for index in 0 ..< count {
      if let result = self[index] as? T {
        array.append(result)
      }
    }
    return array
  }

}


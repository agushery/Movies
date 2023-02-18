//
//  LocalDataSource.swift
//  Movies
//
//  Created by Agus Hery on 12/02/23.
//  Copyright © 2023 Agus Hery. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift

protocol LocalDataSource: AnyObject {
    
    func getPopularMovies() -> Observable<[PopularMovieEntity]>
    
    func addPopularMovies(from movies: [PopularMovieEntity]) -> Observable<Bool>
    
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
    
    func getPopularMovies() -> Observable<[PopularMovieEntity]> {
        return Observable<[PopularMovieEntity]>.create { observer in
            if let realm = self.realm {
                let movies: Results<PopularMovieEntity> = {
                    realm.objects(PopularMovieEntity.self)
                }()
                observer.onNext(movies.toArray(ofType: PopularMovieEntity.self))
                observer.onCompleted()
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
    
    
//    func addPopularMovies(
//        from movies: [PopularMovieEntity],
//        result: @escaping (Result<Bool, DatabaseError>) -> Void
//    ) {
//        if let realm = realm {
//            DispatchQueue.main.async {
//                do {
//                    try realm.write {
//                        for movie in movies {
//                            realm.add(movie, update: .all)
//                        }
//                    }
//                    result(.success(true))
//                } catch {
//                    result(.failure(.requestFailed))
//                }
//            }
//        } else {
//            result(.failure(.invalidInstance))
//        }
//    }
    
    func addPopularMovies(
        from movies: [PopularMovieEntity]
    ) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            if let realm = self.realm {
                do {
                    try realm.write({
                        for movie in movies {
                            realm.add(movies, update: .all)
                        }
                    })
                } catch {
                    observer.onError(DatabaseError.requestFailed)
                }
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
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


//
//  Injection.swift
//  Movies
//
//  Created by Agus Hery on 10/02/23.
//

import Foundation
import RealmSwift

/**
A class responsible for providing dependencies needed by the application.

The Injection class provides an instance of the MovieRepository class, which acts as a single source of truth for the application's data. It also provides instances of the HomeUseCase and DetailUseCase classes, which are responsible for providing data to the Home and Detail views respectively.
*/
class Injection: NSObject {
    
    /**
     Provides an instance of the MovieRepository class, which acts as a single source of truth for the application's data.
     
     - Returns: An instance of the MovieRepository class.
     */
    private func provideRepository() -> MovieRepository {
        let realm = try? Realm()
        let localeDataSource: LocalDataSource = LocalDataSourceImpl.sharedInstance(realm)
        let remoteDataSource: RemoteDataSource = RemoteDataSourceImpl.sharedInstance
        return MovieRepository.sharedInstance(localeDataSource, remoteDataSource)
    }
    
    /**
     Provides an instance of the HomeUseCase class, which is responsible for providing data to the Home view.
     
     - Returns: An instance of the HomeUseCase class.
     */
    func provideHome() -> HomeUseCase {
        let repository = provideRepository()
        return HomeInteractor(repository: repository)
    }
    
    /**
     Provides an instance of the DetailUseCase class, which is responsible for providing data to the Detail view.
     
     - Returns: An instance of the DetailUseCase class.
     */
    func provideDetail() -> DetailUseCase {
        let repository = provideRepository()
        return DetailInteractor(repository: repository)
    }
}

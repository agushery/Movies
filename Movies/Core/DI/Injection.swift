//
//  Injection.swift
//  Movies
//
//  Created by Agus Hery on 10/02/23.
//

import Foundation
import RealmSwift

class Injection: NSObject {
    
    private func provideRepository() -> MovieRepository {
        let remoteDataSource = RemoteDataSourceImpl.sharedInstance
        return MovieRepository.sharedInstance(remoteDataSource)
    }
    
    func provideHome() -> HomeUseCase {
        let repository = provideRepository()
        return HomeInteractor(repository: repository)
    }
    
    func provideDetail() -> DetailUseCase {
        let repository = provideRepository()
        return DetailInteractor(repository: repository)
    }
}

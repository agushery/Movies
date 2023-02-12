//
//  LocalDataSource.swift
//  Movies
//
//  Created by Agus Hery on 12/02/23.
//  Copyright © 2023 Agus Hery. All rights reserved.
//

import Foundation

protocol LocalDataSource: AnyObject {
    
    func getPopularMovies(result: @escaping (Result<[PopularMovieEntity], DatabaseError>) -> Void)
    
    func getUpComingMoview(result: @escaping (Result<[PopularMovieEntity], DatabaseError>) -> Void)
    
}

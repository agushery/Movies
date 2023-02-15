//
//  HomeRouter.swift
//  Movies
//
//  Created by Agus Hery on 13/02/23.
//  Copyright © 2023 Agus Hery. All rights reserved.
//

import SwiftUI

class HomeRouter {
    
    func makeDetailView(id: String) -> some View {
        let detailUseCase = Injection.init().provideDetail()
        let presenter = DetailPresenter(detailUseCase: detailUseCase, idMovie: id)
        return DetailView(presenter: presenter)
    }
    
    func makeMoreMovies(to view: HomeViews, presenter: HomePresenter) -> some View {
        if view == .popularMovies {
            return AnyView(PopularMovieView(presenter: presenter))
        }
        return AnyView(UpComingMoviesView(presenter: presenter))
    }
}

enum HomeViews {
    case popularMovies
    case upcomingMovies
}

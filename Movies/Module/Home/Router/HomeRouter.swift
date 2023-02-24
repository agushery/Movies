//
//  HomeRouter.swift
//  Movies
//
//  Created by Agus Hery on 13/02/23.
//  Copyright © 2023 Agus Hery. All rights reserved.
//

import SwiftUI

/// Class representing the Home Router for navigating between views
class HomeRouter {
    
    /// Function to create a detail view with the given movie ID
    /// Returns a view that conforms to the View protocol
    func makeDetailView(id: String) -> some View {
        /// Create an instance of the Detail Use Case from the Dependency Injection container
        let detailUseCase = Injection.init().provideDetail()
        /// Create an instance of the Detail Presenter with the Detail Use Case and Movie ID
        let presenter = DetailPresenter(detailUseCase: detailUseCase, idMovie: id)
        /// Create and return a Detail View with the Detail Presenter
        return DetailView(presenter: presenter)
    }

    /// Function to create a view based on the specified Home view and Presenter
    /// Returns a view that conforms to the View protocol
    func makeMoreMovies(to view: HomeViews, presenter: HomePresenter) -> some View {
        // Check if the view is for Popular Movies
        if view == .popularMovies {
            /// Create and return a Popular Movie View with the Home Presenter
            return AnyView(PopularMovieView(presenter: presenter))
        }
        /// Otherwise, create and return an Upcoming Movies View with the Home Presenter
        return AnyView(UpComingMoviesView(presenter: presenter))
    }

}

/// Enumeration representing the Home Views for more movies
enum HomeViews {
    case popularMovies
    case upcomingMovies
}

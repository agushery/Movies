//
//  PopularMovieView.swift
//  Movies
//
//  Created by Agus Hery on 12/02/23.
//  Copyright © 2023 Agus Hery. All rights reserved.
//

import SwiftUI

/**
 *  PopularMovieView is a SwiftUI view that displays a collection of popular movie data in a vertical grid layout.
 *  This view is made up of multiple instances of PopularMovieViewCell, which are individual cells that display information about a specific movie.
 *
 *  - Parameters:
 *      - data: An array of `MovieModel` objects that represent the movie data that will be displayed in the grid.
 *  - Properties:
 *      - columns: An array of `GridItem` objects that define the layout of the grid. By default, it uses a flexible grid layout.
 *      - navTitle: A string that represents the title of the view that will be displayed in the navigation bar. The default value is "Popular Movies".
 *
 *  - Example usage:
 *      - let popularMovieData = [MovieModel.dummyData, MovieModel.dummyData]
 *      - let popularMovieView = PopularMovieView(data: popularMovieData)
 */

struct PopularMovieView: View {
    /// The `HomePresenter` object that the view will observe for updates.
    @ObservedObject var presenter: HomePresenter

    /// The column layout for the grid view.
    var columns = [GridItem(.flexible())]
    
    /// A state property to store the navigation bar title.
    @State private var navTitle: String = "Popular Movies"
    
    /// The body of the view, which contains a vertical scroll view displaying the grid of popular movies.
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            LazyVGrid(columns: columns) {
                ForEach(presenter.popularMovies) { result in
                    ZStack {
                        self.presenter.linkBuilder(idMovie: result.id) {
                            PopularMovieViewCell(data: result)
                        }
                        .buttonStyle(.plain)
                    }
                    Divider()
                }
            }
        }
        .navigationTitle(navTitle)
        .navigationBarTitleDisplayMode(.inline)
    }
}


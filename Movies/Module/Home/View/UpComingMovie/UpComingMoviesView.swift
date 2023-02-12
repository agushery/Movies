//
//  UpComingMoviesView.swift
//  Movies
//
//  Created by Agus Hery on 11/02/23.
//  Copyright © 2023 Agus Hery. All rights reserved.
//

import SwiftUI


/**
 *  UpComingMoviesView is a SwiftUI view that displays a collection of popular movie data in a vertical grid layout.
 *  This view is made up of multiple instances of UpComingMovieViewCell, which are individual cells that display information about a specific movie.
 *
 *  - Parameters:
 *      - data: An array of `MovieModel` objects that represent the movie data that will be displayed in the grid.
 *  - Properties:
 *      - columns: An array of `GridItem` objects that define the layout of the grid. By default, it uses a flexible grid layout.
 *      - navTitle: A string that represents the title of the view that will be displayed in the navigation bar. The default value is "Upcoming Movies".
 *
 *  - Example usage:
 *      - let upComingMovieData = [UpComingMovieModel.dummyData, MovieModel.dummyData]
 *      - let upComingMovieView = UpComingMoviesView(data: popularMovieData)
 */
struct UpComingMoviesView: View {

    // data: [UpComingMovieModel]
    /// This property holds an array of `MovieModel` objects that will be used to display each movie.
    var data: [MovieModel]
    
    // columns: [GridItem]
    /// This property holds the columns of the grid layout used to display the movie cells.
    var columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    /// This property holds the title navigation.
    @State private var navTitle: String = "Upcoming Movies"
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            LazyVGrid(columns: columns) {
                ForEach(data) { result in
                    UpComingMovieViewCell(data: result)
                }
            }
        }
        .navigationTitle(navTitle)
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Preview Provider
struct UpComingMoviesView_Previews: PreviewProvider {
    static var previews: some View {
        UpComingMoviesView(data: [MovieModel.dummyData])
    }
}


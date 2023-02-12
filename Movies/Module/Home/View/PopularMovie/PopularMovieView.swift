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
    
    /// The data model for each movie.
    var data: [MovieModel]
    
    /// The column layout for the grid view.
    var columns = [GridItem(.flexible())]
    
    /// A state property to store the navigation bar title.
    @State private var navTitle: String = "Popular Movies"
    
    /// The body of the view, which contains a vertical scroll view displaying the grid of popular movies.
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            LazyVGrid(columns: columns) {
                ForEach(data) { result in
                    PopularMovieViewCell(data: result)
                    Divider()
                }
            }
        }
        .navigationTitle(navTitle)
        .navigationBarTitleDisplayMode(.inline)
    }
}

/// A preview provider for the PopularMovieView.
struct PopularMovieView_Previews: PreviewProvider {
    static var previews: some View {
        PopularMovieView(data: [MovieModel.dummyData])
    }
}


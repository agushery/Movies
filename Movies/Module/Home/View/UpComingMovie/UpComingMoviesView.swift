//
//  UpComingMoviesView.swift
//  Movies
//
//  Created by Agus Hery on 11/02/23.
//  Copyright © 2023 Agus Hery. All rights reserved.
//

import SwiftUI

/// This struct represents a view for a collection of upcoming movies.
struct UpComingMoviesView: View {

    // data: [UpComingMovieModel]
    /// This property holds an array of `UpComingMovieModel` objects that will be used to display each movie.
    var data: [UpComingMovieModel]
    
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
        UpComingMoviesView(data: [UpComingMovieModel.dummyData])
    }
}


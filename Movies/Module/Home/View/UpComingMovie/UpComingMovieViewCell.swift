//
//  UpComingMovieViewCell.swift
//  Movies
//
//  Created by Agus Hery on 11/02/23.
//  Copyright © 2023 Agus Hery. All rights reserved.
//

import SwiftUI

/// A custom `View` that represents a movie in the Upcoming Movie section.
struct UpComingMovieViewCell: View {
    
    /// The data for the movie to be displayed.
    var data: UpComingMovieModel
    
    /// The body of the `View`.
    var body: some View {
        VStack {
            imageMovie
            title
        }
        
    }
}

// MARK: - Private View Variables
extension UpComingMovieViewCell {
    
    /// A `View` that displays the movie poster.
    private var imageMovie: some View {
        AsyncImage(url: URL(string: API.baseIMGURL+data.posterPath)) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }
        .aspectRatio(contentMode: .fit)
        .cornerRadius(15)
        .frame(width: 250, height: 200)
    }
    
    /// A `View` that displays the title of the movie.
    private var title: some View {
        Text(data.title)
            .font(.system(.caption, design: .rounded, weight: .medium))
            .frame(width: 150)
            .lineLimit(1)
    }
}

// MARK: - Preview Provider
struct UpComingMovieCell_Previews: PreviewProvider {
    static var previews: some View {
        UpComingMovieViewCell(data: UpComingMovieModel.dummyData)
    }
}

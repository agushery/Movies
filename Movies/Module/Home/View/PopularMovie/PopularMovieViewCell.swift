//
//  PopularMovieViewCell.swift
//  Movies
//
//  Created by Agus Hery on 12/02/23.
//  Copyright © 2023 Agus Hery. All rights reserved.
//

import SwiftUI

/// A SwiftUI view representing a cell in a list of popular movies.
struct PopularMovieViewCell: View {
    
    /// The data model for the popular movie being displayed.
    var data: MovieModel
    
    /// A Boolean value indicating whether the full overview text should be shown or not.
    @State private var isFullTextShown = false
    
    var body: some View {
        HStack(alignment: .top, spacing: -40) {
            imageMovie
            VStack(alignment: .leading, spacing: 5){
                title
                overView
                rating
            }.frame(width: 200)
        }.padding(.leading, -40)
    }
}

// MARK: - PopularMovieViewCell Extension

extension PopularMovieViewCell {
    
    /// A view representing the movie poster image.
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
    
    /// A view representing the movie title.
    private var title: some View {
        Text(data.title)
            .font(.system(.title3, design: .rounded, weight: .medium))
            .lineLimit(3)
        
    }
    
    /// A view representing the movie overview text.
    private var overView: some View {
        VStack(alignment: .leading){
            Text(data.overview)
                .lineLimit(isFullTextShown ? nil : 7)
                .font(.system(.caption, design: .default, weight: .regular))
            Button(action: {
                self.isFullTextShown.toggle()
            }) {
                Text(isFullTextShown ? "Show Less" : "Show More")
                    .font(.system(.caption, design: .default, weight: .regular))
            }
        }
        
    }
    
    /// A view representing the movie rating.
    private var rating: some View {
        HStack {
            Image(systemName: "star")
            Text(String(format: "%.1f", data.voteAverage))
        }
    }
    
}

struct PopularMovieViewCell_Previews: PreviewProvider {
    static var previews: some View {
        PopularMovieViewCell(data: MovieModel.dummyData)
    }
}

//
//  DetailView.swift
//  Movies
//
//  Created by Agus Hery on 12/02/23.
//  Copyright © 2023 Agus Hery. All rights reserved.
//

import SwiftUI


/// A SwiftUI view that displays the detailed information of a selected movie.
struct DetailView: View {
    
    /// An `ObservedObject` that holds the `DetailPresenter` for this view. The `DetailPresenter` provides the necessary data for the view to display.
    @ObservedObject var presenter: DetailPresenter
    
    /// A `State` variable that holds the selected trailer for the movie.
    @State private var selectedTrailer: VideoModel?
    
    /// The body of the `DetailView`.
    var body: some View {
        ZStack {
            if presenter.loadingState {
                VStack {
                    ProgressView()
                    Text("Loading...")
                }
            } else {
                ScrollView {
                    backdropImage
                    topCard
                    VStack(alignment: .leading ,spacing: 10){
                        DecriptionDetailView(presenter: presenter)
                        if !presenter.videosMovie.isEmpty {
                            trailers
                        }
                        Divider()
                        if !presenter.detailMovie.homepage.isEmpty {
                            website
                        }
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}


extension DetailView {
    /// A private computed property that returns a `VStack` containing the poster image for the movie. If the poster path is not found, it displays a "Not Found" message.
    private var posterMovie: some View {
        VStack {
            if let posterPath = presenter.detailMovie.posterPath {
                ZStack {
                    Rectangle()
                        .frame(width: 108, height: 147)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                    RemoteImageView(url: posterPath)
                    .frame(width: 100, height: 140)
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(10)
                }
            } else {
                Text("Not Found")
            }
        }
    }
    
    /// A private computed property that returns a `VStack` containing the backdrop image for the movie. If the backdrop path is not found, it displays a black rectangle with a "Not Found" message.
    private var backdropImage: some View {
        VStack {
            if let backdrop = presenter.detailMovie.backdropPath {
                    RemoteImageView(url: backdrop)
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 219)
            } else {
                ZStack {
                    Rectangle()
                        .foregroundColor(.black)
                        .frame(height: 220)
                    Text("Not Found")
                        .foregroundColor(.white)
                }
            }
        }
    }
    
    /// A private computed property that returns a `HStack` containing the top card of the view. It displays the poster image, title, rating, release date, and genres for the movie.
    private var topCard: some View {
        HStack (alignment: .center, spacing: 10) {
            posterMovie
                .offset(CGSize(width: 0, height: -40))
            VStack(alignment: .leading){
                StrokeTextView(text: presenter.detailMovie.title, width: 1, color: .white)
                    .font(.system(.title2, design: .default, weight: .bold))
                    .offset(x: 0, y: -20)
                HStack (alignment: .center) {
                    Image(systemName: "star")
                    Text(String(format: "%.1f", presenter.detailMovie.voteAverage))
                    Divider()
                        .frame(height: 20)
                    Image(systemName: "calendar")
                    Text(presenter.detailMovie.releaseDate)
                }
                HStack(spacing: 20){
                    ForEach(presenter.detailMovie.genres.prefix(2)) { genre in
                        Text(genre.name)
                            .bold()
                    }
                }
            }
            .offset(CGSize(width: 0, height: -35))
            Spacer()
        }
        .padding(.top, -30)
        .padding(.horizontal)
    }
    
    /// A private computed property that returns a `VStack` containing the trailers for the movie. It displays the name of the trailer and a play button. When the play button is tapped, it opens the trailer in a `SafariView`.
    private var trailers: some View {
        VStack(alignment: .leading, spacing: 10){
            Text("Trailers:")
                .font(.system(.headline, design: .default, weight: .semibold))
            ForEach(presenter.videosMovie.prefix(3), id: \.self) { trailer in
                if trailer.site == siteYoutube {
                    Button {
                        self.selectedTrailer = trailer
                    } label: {
                        HStack (alignment: .center) {
                            Text(trailer.name)
                                .multilineTextAlignment(.leading)
                            Spacer()
                            Image(systemName: "play.circle.fill")
                                .foregroundColor(Color(UIColor.systemBlue))
                        }
                    }
                }
            }
        }
        .padding(.horizontal)
        .sheet(item: $selectedTrailer) { trailer in
            SafariView(url: trailer.key)
        }
    }
    
    /// A private computed property that returns a `VStack` containing the website for the movie.
    private var website: some View {
        VStack(alignment: .leading){
            Text("Website")
                .font(.system(.headline, design: .default, weight: .semibold))
            Text(.init(presenter.detailMovie.homepage))
                .font(.system(.caption, design: .default, weight: .regular))
        }.padding(.horizontal)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        let detailUseCase = Injection.init().provideDetail()
        DetailView(presenter: DetailPresenter(detailUseCase: detailUseCase, idMovie: "5"))
    }
}

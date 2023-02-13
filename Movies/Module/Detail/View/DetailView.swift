//
//  DetailView.swift
//  Movies
//
//  Created by Agus Hery on 12/02/23.
//  Copyright © 2023 Agus Hery. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    
    @ObservedObject var presenter: DetailPresenter
    
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
                    HStack {
                        topCard
                        Spacer()
                    }.padding(.horizontal)
                    VStack(alignment: .leading, spacing: 10){
                        Text(presenter.detailMovie.originalTitle)
                            .font(.system(.title, design: .default, weight: .bold))
                        Text(presenter.detailMovie.overview)
                            .font(.system(.caption, design: .default, weight: .regular))
                        Divider()
                        Text("Website:")
                            .font(.system(.headline, design: .default, weight: .semibold))
                        Text(.init(presenter.detailMovie.homepage))
                            .font(.system(.caption, design: .default, weight: .regular))
                    }
                    .padding(.horizontal)
                    .padding(.top, -40)
                }
                .ignoresSafeArea()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

extension DetailView {
    
    private var posterMovie: some View {
        VStack {
            if let posterPath = presenter.detailMovie.posterPath {
                ZStack {
                    Rectangle()
                        .frame(width: 108, height: 147)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                    AsyncImage(url: URL(string: API.baseIMGURL+posterPath)) { image in
                        image
                            .resizable()
                            .frame(width: 100, height: 140)
                    } placeholder: {
                        ProgressView()
                    }
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(10)
                }
            } else {
                Image(systemName: "person")
                Text("Not Found")
            }
        }
    }
    
    private var backdropImage: some View {
        VStack {
            if let backdrop = presenter.detailMovie.backdropPath {
                    AsyncImage(url: URL(string: API.baseIMGURL+backdrop)) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
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
    
    private var topCard: some View {
        HStack (alignment: .top, spacing: 10) {
            posterMovie
                .offset(CGSize(width: 0, height: -40))
            VStack(alignment: .leading){
                StrokeText(text: presenter.detailMovie.title, width: 1, color: .white)
                    .font(.system(.title2, design: .default, weight: .bold))
                HStack (alignment: .center) {
                    Image(systemName: "star")
                    Text(String(format: "%.1f", presenter.detailMovie.voteAverage))
                    Divider()
                        .frame(height: 20)
                    Image(systemName: "play.laptopcomputer")
                    Text(String(presenter.detailMovie.popularity))
                }.padding(.top, presenter.detailMovie.title.count > 20 ? -5 : 40)
                HStack {
                    ForEach(presenter.detailMovie.genres.prefix(2)) { genre in
                        Text(genre.name)
                            .bold()
                    }
                }
            }
            .offset(CGSize(width: 0, height: -35))
        }
        .padding(.top, -30)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        let detailUseCase = Injection.init().provideDetail()
        DetailView(presenter: DetailPresenter(detailUseCase: detailUseCase, idMovie: "22"))
    }
}

private struct StrokeText: View {
    let text: String
    let width: CGFloat
    let color: Color

    var body: some View {
        ZStack{
            ZStack{
                Text(text).offset(x:  width, y:  width)
                Text(text).offset(x: -width, y: -width)
                Text(text).offset(x: -width, y:  width)
                Text(text).offset(x:  width, y: -width)
            }
            .font(.system(.title2, design: .default, weight: .semibold))
            .foregroundColor(color)
            Text(text)
                .font(.system(.title2, design: .default, weight: .semibold))
                .foregroundColor(.black)
        }
    }
}

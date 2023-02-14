//
//  HomeView.swift
//  Movies
//
//  Created by Agus Hery on 11/02/23.
//  Copyright © 2023 Agus Hery. All rights reserved.
//

import SwiftUI

/// The `HomeView` struct is the main view of the home screen in the Movies app.
/// It displays a list of upcoming movies and provides navigation to the `UpComingMoviesView`.
struct HomeView: View {
    
    /// The `HomePresenter` object that the view will observe for updates.
    @ObservedObject var presenter: HomePresenter
    
    /// The title to display in the navigation bar.
    @State var navTitle = "Movies"
    
    /// A flag to control the active state of the `UpComingMoviesView` navigation link.
    @State private var isMoreUpComingMovies: Bool = false
    
    /// A flag to control the active state of the `PopularMoviesView` navigation link.
    @State private var isMorePopularMovies: Bool = false
    
    var body: some View {
        ZStack {
            if presenter.loadingState {
                VStack {
                    Text("Loading")
                    ProgressView()
                }
            } else {
                ScrollView {
                    if presenter.userQuery.isEmpty {
                        VStack(alignment: .leading, spacing: 20){
                            popularMovies
                            upComingMovie
                        }
                        
                    } else {
                        searchMovies
                    }
                }
            }
        }
        .onReceive(presenter.$userQuery.debounce(for: 0.5, scheduler: RunLoop.main), perform: { newValue in
            self.presenter.searchMovies(query: newValue)
        })
        .navigationTitle(navTitle)
        .searchable(text: $presenter.userQuery, prompt: "Search movie...")
    }
}

// MARK: - Private views

extension HomeView {
    
    /// The `popularMovie` view displays the list of upcoming movies.
    private var popularMovies: some View {
        VStack {
            NavigationLink(isActive: $isMorePopularMovies) {
                PopularMovieView(presenter: presenter, data: presenter.popularMovies)
            } label: {
                EmptyView()
            }
            HStack {
                Text("Popular Movies")
                    .padding(.leading)
                    .font(.system(.title2, design: .default, weight: .bold))
                Spacer()
                Button {
                    isMorePopularMovies = true
                } label: {
                    HStack(alignment: .center) {
                        Spacer()
                        Text("Show More")
                            .font(.system(size: 14, weight: .semibold))
                            .padding(.trailing)
                    }
                }
            }
            ScrollView {
                ForEach(presenter.popularMovies.prefix(3)) { result in
                    VStack {
                        ZStack {
                            self.presenter.linkBuilder(idMovie: result.id) {
                                PopularMovieViewCell(data: result)
                            }
                            .buttonStyle(.plain)
                        }
                        Divider()
                    }
                }
            }.padding(.leading, -20)
        }
    }
    
    /// The `upComingMovie` view displays the list of upcoming movies.
    private var upComingMovie: some View {
        VStack {
            NavigationLink(isActive: $isMoreUpComingMovies) {
                UpComingMoviesView(presenter: presenter)
            } label: {
                EmptyView()
            }
            HStack {
                Text("Upcoming Movies")
                    .padding(.leading)
                    .font(.system(.title2, design: .default, weight: .bold))
                Spacer()
                Button {
                    isMoreUpComingMovies = true
                } label: {
                    HStack(alignment: .center) {
                        Spacer()
                        Text("Show More")
                            .font(.system(size: 14, weight: .semibold))
                            .padding(.trailing)
                    }
                }
            }
            ScrollView(.horizontal, showsIndicators: false){
                HStack(spacing: -90){
                    ForEach(presenter.upcomingMovies.prefix(5)) { result in
                        ZStack {
                            self.presenter.linkBuilder(idMovie: result.id) {
                                UpComingMovieViewCell(data: result)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
            }.padding(.leading, -40)
        }
    }
    
    /// The `searchMovies` view displays the list of movies that search by user.
    private var searchMovies: some View {
        VStack(alignment: .leading){
            if presenter.searchMoviesData.isEmpty {
                Spacer()
                VStack(alignment: .center){
                    Image(systemName: "arrow.counterclockwise.icloud")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 50)
                    Text("Try anothers one or add more keywords...")
                }
            } else {
                Text("Found \(presenter.searchMoviesData.count) movies contains: \(presenter.userQuery)").padding(.leading)
            }
            ForEach(presenter.searchMoviesData, id: \.releaseDate) { data in
                self.presenter.linkBuilder(idMovie: data.id) {
                    PopularMovieViewCell(data: data)
                }
                .buttonStyle(.plain)
                Divider()
            }
        }.padding(.horizontal)
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let homeUseCase = Injection.init().provideHome()
        HomeView(presenter: HomePresenter(homeUseCase: homeUseCase))
    }
}

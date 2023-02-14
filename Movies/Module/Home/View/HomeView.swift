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
                    VStack(alignment: .leading, spacing: 20){
                        popularMovies
                        upComingMovie
                    }
                }
            }
        }
        .navigationTitle(navTitle)
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
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let homeUseCase = Injection.init().provideHome()
        HomeView(presenter: HomePresenter(homeUseCase: homeUseCase))
    }
}

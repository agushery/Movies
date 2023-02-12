//
//  HomePresenter.swift
//  Movies
//
//  Created by Agus Hery on 11/02/23.
//  Copyright © 2023 Agus Hery. All rights reserved.
//

import Foundation
import SwiftUI

class HomePresenter: ObservableObject {
    
    private var homeUseCase: HomeUseCase
    private var router = HomeRouter()
    
    @Published var popularMovies: [MovieModel] = []
    @Published var upcomingMovies: [MovieModel] = []
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    
    init(homeUseCase: HomeUseCase) {
        self.homeUseCase = homeUseCase
    }
    
}

// MARK: - Get Popular Movies
extension HomePresenter {
    func getPopularMovies() {
        loadingState = true
        homeUseCase.getPopularMovies { result in
            switch result {
            case .success(let movieResults):
                DispatchQueue.main.async {
                    self.loadingState = false
                    self.popularMovies = movieResults
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.loadingState = false
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}

// MARK: - Get Upcoming Movies
extension HomePresenter {
    func getUpcomingMovies() {
        loadingState = true
        homeUseCase.getUpcomingMovies { result in
            switch result {
            case .success(let movieResults):
                DispatchQueue.main.async {
                    self.loadingState = false
                    self.upcomingMovies = movieResults
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.loadingState = false
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}

// MARK: - Link Builder
extension HomePresenter {
    
    func linkBuilder<Content: View>(
        idMovie: String,
        @ViewBuilder content: () -> Content
    ) -> some View {
      NavigationLink(
        destination: router.makeDetailView(id: idMovie)) { content() }
    }
    
}

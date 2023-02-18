//
//  DetailPresenter.swift
//  Movies
//
//  Created by Agus Hery on 12/02/23.
//  Copyright © 2023 Agus Hery. All rights reserved.
//

import Foundation

/**
 *  `DetailPresenter` is an ObservableObject that provides the necessary data and business logic to be used in the `DetailView` for displaying details and videos of a movie.
*/
class DetailPresenter: ObservableObject {
    
    private let detailUseCase: DetailUseCase
    private let idMovie: String
    
    @Published var detailMovie: DetailMovieModel = DetailMovieModel.dummyData
    @Published var videosMovie: [VideoModel] = []
    @Published var loadingState: Bool = false
    
    init(detailUseCase: DetailUseCase, idMovie: String) {
        self.detailUseCase = detailUseCase
        self.idMovie = idMovie
        getDetailMovie()
        getVideosMovie()
    }
    
    /**
     Calls the `getDetailMovie` method of the `DetailUseCase` object to fetch the detailed information of the movie for the given id.
     Updates the `detailMovie` and `loadingState` properties when the data is fetched successfully.
     */
    func getDetailMovie() {
        detailUseCase.getDetailMovie(completion: { result in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self.loadingState = false
                    self.detailMovie = success
                }
            case .failure(let failure):
                print(failure)
            }
        }, idMovie: self.idMovie)
    }
    
    /**
     Calls the `getVideosMovie` method of the `DetailUseCase` object to fetch the videos of the movie for the given id.
     Updates the `videosMovie` and `loadingState` properties when the data is fetched successfully.
     */
    func getVideosMovie() {
        detailUseCase.getVideosMovie(completion: { result in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self.loadingState = false
                    self.videosMovie = success
                }
            case .failure(let failure):
                print(failure)
            }
        }, idMovie: self.idMovie)
    }
}

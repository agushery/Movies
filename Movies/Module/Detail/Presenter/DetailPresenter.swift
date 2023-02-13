//
//  DetailPresenter.swift
//  Movies
//
//  Created by Agus Hery on 12/02/23.
//  Copyright © 2023 Agus Hery. All rights reserved.
//

import Foundation

class DetailPresenter: ObservableObject {
    
    private let detailUseCase: DetailUseCase
    private let idMovie: String
    
    @Published var detailMovie: DetailMovieModel = DetailMovieModel.dummyData
    @Published var videosMovie: [VideoModel] = []
    @Published var loadingState: Bool = false
    
    init(detailUseCase: DetailUseCase, idMovie: String) {
        self.detailUseCase = detailUseCase
        self.idMovie = idMovie
        
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

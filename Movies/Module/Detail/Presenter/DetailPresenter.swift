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
    @Published var loadingState: Bool = false
    
    init(detailUseCase: DetailUseCase, idMovie: String) {
        self.detailUseCase = detailUseCase
        self.idMovie = idMovie
    }
    
    func getDetailMovie() {
        loadingState = true
        detailUseCase.getDetailMovie(completion: { result in
            switch result {
            case .success(let movie):
                DispatchQueue.main.async {
                    self.detailMovie = movie
                    self.loadingState = false
                }
            case .failure(let error):
                print(error)
            }
        }, idMovie: idMovie)
    }
}

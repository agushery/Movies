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
                Text(presenter.detailMovie.title)
            }
        }
        .onAppear {
            self.presenter.getDetailMovie()
        }
    }
}


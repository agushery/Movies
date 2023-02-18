//
//  DecriptionDetailView.swift
//  Movies
//
//  Created by Agus Hery on 13/02/23.
//  Copyright © 2023 Agus Hery. All rights reserved.
//

import SwiftUI

/**
 A view that displays the details of a movie, including the movie's original title and description.
 
 To use this view, create an instance and pass in a DetailPresenter object, which is responsible for providing the movie's details to the view.
 
 * Parameter
    - presenter: The DetailPresenter object that provides the movie's details to the view.
 */
struct DecriptionDetailView: View {
    
    /// The DetailPresenter object that provides the movie's details to the view.
    @ObservedObject var presenter: DetailPresenter
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            Text(presenter.detailMovie.originalTitle)
                .font(.system(.title, design: .default, weight: .bold))
            Text(presenter.detailMovie.overview)
                .font(.system(.caption, design: .default, weight: .regular))
            Divider()
        }
        .padding(.top, -40)
        .padding(.horizontal)
    }
}


struct DecriptionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let detailUseCase = Injection.init().provideDetail()
        DecriptionDetailView(presenter: DetailPresenter(detailUseCase: detailUseCase, idMovie: "2"))
    }
}

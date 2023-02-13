//
//  DecriptionDetailView.swift
//  Movies
//
//  Created by Agus Hery on 13/02/23.
//  Copyright © 2023 Agus Hery. All rights reserved.
//

import SwiftUI

struct DecriptionDetailView: View {
    
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

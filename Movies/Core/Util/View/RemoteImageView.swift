//
//  RemoteImageView.swift
//  Movies
//
//  Created by Agus Hery on 13/02/23.
//  Copyright © 2023 Agus Hery. All rights reserved.
//

import SwiftUI

struct RemoteImageView: View {
    
    var url: String
    
    var body: some View {
        AsyncImage(url: URL(string: API.baseIMGURL+url)) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }
    }
}

struct RemoteImageView_Previews: PreviewProvider {
    static var previews: some View {
        RemoteImageView(url: MovieModel.dummyData.posterPath)
    }
}

//
//  RemoteImageView.swift
//  Movies
//
//  Created by Agus Hery on 13/02/23.
//  Copyright © 2023 Agus Hery. All rights reserved.
//

import SwiftUI
import Kingfisher

/**
 A SwiftUI view that displays an image loaded from a remote URL using Kingfisher.

 - Parameter url: The remote URL of the image to display.

 - Returns  A SwiftUI view that displays the loaded image, or "Not Found" text if the URL is nil.
 
 */
struct RemoteImageView: View {
    
    var url: String?
    
    var body: some View {
        if let url = url {
            KFImage.url(URL(string: API.baseIMGURL+url))
                .placeholder { _ in
                    ProgressView().tint(.white)
                }
                .cacheMemoryOnly()
                .fade(duration: 0.25)
                .resizable()
        } else {
            Text("Not Found")
        }
    }
}


struct RemoteImageView_Previews: PreviewProvider {
    static var previews: some View {
        RemoteImageView(url: MovieModel.dummyData.posterPath!)
    }
}

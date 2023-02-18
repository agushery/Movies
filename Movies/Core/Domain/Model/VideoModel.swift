//
//  VideoModel.swift
//  Movies
//
//  Created by Agus Hery on 13/02/23.
//  Copyright © 2023 Agus Hery. All rights reserved.
//

import Foundation

/// The `VideoModel` struct represents a video response for display in the view.
struct VideoModel: Hashable, Identifiable {
    /// The ISO 639-1 language code for the video.
    let iso_639_1: String
    /// The ISO 3166-1 country code for the video.
    let iso_3166_1: String
    /// The name of the video.
    let name: String
    /// The key used to access the video.
    let key: String
    /// The date and time the video was published.
    let published_at: String
    /// The site where the video is hosted.
    let site: String
    /// The size of the video in pixels.
    let size: Int
    /// The type of video, such as "Trailer" or "Teaser".
    let type: String
    /// Indicates if the video is official or not.
    let official: Bool
    /// The unique identifier for the video.
    let id: String
}

extension VideoModel {
    /// Maps an array of `Video` objects to an array of `VideoModel` objects.
    static func mapVideoResponseToDomain(
        input videoResponse: [Video]
    ) -> [VideoModel]
    {
        return videoResponse.map { result in
            return VideoModel(
                iso_639_1: result.iso_639_1,
                iso_3166_1: result.iso_3166_1,
                name: result.name,
                key: result.key,
                published_at: result.published_at,
                site: result.site,
                size: result.size,
                type: result.type,
                official: result.official,
                id: result.id
            )
        }
    }
}

extension VideoModel {
    /// A sample `VideoModel` object used for testing and development purposes.
    static let dummyData: VideoModel = VideoModel(
        iso_639_1: "",
        iso_3166_1: "",
        name: "Finding Nemo (2003) Trailer 2",
        key: "ZS_8btMjx2U",
        published_at: "2018-02-11T21:53:36.000Z",
        site: "Youtube",
        size: 360,
        type: "Trailer",
        official: false,
        id: "5a80bc1ac3a36818a7026cc8"
    )
}

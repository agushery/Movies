//
//  VideoResponse.swift
//  Movies
//
//  Created by Agus Hery on 13/02/23.
//  Copyright © 2023 Agus Hery. All rights reserved.
//

import Foundation


/// Represents the response from a video API
struct VideoResponse: Codable {
    /// Unique identifier for the response
    let id: Int
    /// Array of video information
    let results: [Video]
}

/// Represents the information for a single video
struct Video: Codable, Identifiable {
    /// ISO 639-1 language code
    let iso_639_1: String
    /// ISO 3166-1 country code
    let iso_3166_1: String
    /// Name of the video
    let name: String
    /// Key used to access the video
    let key: String
    /// Date and time the video was published
    let published_at: String
    /// Site where the video is hosted
    let site: String
    /// Size of the video in pixels
    let size: Int
    /// Type of video (e.g. Trailer, Teaser)
    let type: String
    /// Indicates if the video is official or not
    let official: Bool
    /// Unique identifier for the video
    let id: String
}


//
//  APICall.swift
//  Movies
//
//  Created by Agus Hery on 10/02/23.
//

import Foundation

/// This struct holds the information required to interact with the The Movie Database API
struct API {
  
    /// The base URL for the API
    static let baseURL: String = "https://api.themoviedb.org/3/"
    
    /// The base URL for poster IMG
    static let baseIMGURL: String = "https://image.tmdb.org/t/p/w500"
  
    /// The API key required for making requests to the API
    static var apiKey: String {
        get {
            // Retrieve the API key from the TMDB.plist file
            guard let filePath = Bundle.main.path(forResource: "TMDB", ofType: "plist") else {
                // If the file couldn't be found, throw a fatal error
                fatalError("Couldn't find file 'TMDB.plist'.")
            }
            // Load the contents of the plist file
            let plist = NSDictionary(contentsOfFile: filePath)
            // Retrieve the API key from the plist file
            guard let value = plist?.object(forKey: "API_KEY") as? String else {
                // If the API key couldn't be found in the plist file, throw a fatal error
                fatalError("Couldn't find key 'API_KEY'")
            }
            // Return the API key
            return value
        }
    }
  
}

/// Protocol that defines the requirements for an endpoint
protocol EndPoint {
    /// The URL associated with the endpoint
    var url: String { get }
}

/// Enum that holds the various endpoints available for the The Movie Database API
enum EndPoints {
  
    /// Endpoints for retrieving movie data
    enum Gets: EndPoint {
        /// Endpoint for retrieving upcoming movies
        case upcoming
        /// Endpoint for retrieving popular movies
        case popular
        /// Endpoint for retrieving detail movie
        case detail(id: String)
        /// Endpoint for retrieving video
        case video(id: String)
        /// Endpoint for youtube player
        case youtubeURL(key: String)
        
        case search(query: String)
    
        /// The URL associated with the endpoint
        var url: String {
            switch self {
                case .upcoming:
                    return "\(API.baseURL)movie/upcoming?api_key=\(API.apiKey)"
                case .popular:
                    return "\(API.baseURL)movie/popular?api_key=\(API.apiKey)"
                case .detail(let id):
                    return "\(API.baseURL)movie/\(id)?api_key=\(API.apiKey)"
                case .video(let id):
                    return "\(API.baseURL)movie/\(id)/videos?api_key=\(API.apiKey)"
                case .youtubeURL(let key):
                    return "https://youtube.com/watch?v=\(key)"
                case .search(let query):
                    return "\(API.baseURL)search/movie?api_key=\(API.apiKey)&query=\(query)"
            }
        }
    }
}


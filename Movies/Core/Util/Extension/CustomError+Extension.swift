//
//  CustomError+Extension.swift
//  Movies
//
//  Created by Agus Hery on 10/02/23.
//  Copyright © 2023 Agus Hery. All rights reserved.
//

import Foundation

/// Enum representing URL related errors
enum URLError: LocalizedError {
    
    /// Invalid response from the server
    case invalidResponse
    
    /// URL is unreachable
    case addressUnReseachable(URL)
    
    /// A localized error description
    var errorDescription: String? {
        switch self {
            case .invalidResponse:
                return "The server responded with garbage."
            case .addressUnReseachable(let url):
                return "\(url.absoluteString) is unreachable."
        }
    }
    
}

/// Enum representing database related errors
enum DatabaseError: LocalizedError {
    
    /// Invalid database instance
    case invalidInstance
    
    /// Request to the database failed
    case requestFailed
    
    /// A localized error description
    var errorDescription: String? {
        switch self {
        case .invalidInstance:
            return "Database can't instance"
        case .requestFailed:
            return "Your request failed"
        }
    }
}


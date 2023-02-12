//
//  JSONNull+Extention.swift
//  Movies
//
//  Created by Agus Hery on 13/02/23.
//  Copyright © 2023 Agus Hery. All rights reserved.
//

import Foundation

/// Represents a JSON null value in a decoded JSON object.
class JSONNull: Codable, Hashable {

    /// Returns `true` if two `JSONNull` instances are equal.
    static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    /// Initializes a new instance of `JSONNull`.
    init() {}

    /// Decodes a `JSONNull` instance from a decoder.
    required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    /// Encodes a `JSONNull` instance to an encoder.
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }

    /// Hashes the `JSONNull` instance into the specified hasher.
    func hash(into hasher: inout Hasher) {
        hasher.combine(0)
    }
}

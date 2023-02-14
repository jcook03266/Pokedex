//
//  JSONParsingHelper+JSONEncodingHelper.swift
//  Pokedex
//
//  Created by Justin Cook on 2/13/23.
//

import Foundation

/// Helpers that simplify the process of encoding and decoding JSONs from and to codable values
struct JSONParsingHelper {
    /// Parse any type that conforms to the decodable protocol with this method
    static func parseJSON<T: Decodable>(with type: T.Type,
                                  using data: Data) throws -> T {
        do {
            return try JSONDecoder().decode(type, from: data)
        }
        catch {
            ErrorCodeDispatcher.SwiftErrors.printErrorCode(for: .jsonCouldNotBeParsed)
            throw error
        }
    }
}

struct JSONEncodingHelper {
    static func encode<T: Encodable>(using value: T) throws -> Data {
        do {
            return try JSONEncoder().encode(value)
        }
        catch {
            ErrorCodeDispatcher.SwiftErrors.printErrorCode(for: .jsonCouldNotBeEncoded)
            throw error
        }
    }
    
    /// Encodes the encodable value to a human readable JSON format using UTF8 encoding
    static func encodeToJSON<T: Encodable>(using value: T) throws -> String {
        do {
            return try String(data: self.encode(using: value),
                              encoding: .utf8)!
        }
        catch {
            ErrorCodeDispatcher.SwiftErrors.printErrorCode(for: .jsonCouldNotBeEncoded)
            throw error
        }
    }
}

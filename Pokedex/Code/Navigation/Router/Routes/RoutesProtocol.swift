//
//  RoutesProtocol.swift
//  Pokedex
//
//  Created by Justin Cook on 2/13/23.
//

import Foundation

// MARK: - Generic protocol for all routes to conform to
protocol RoutesProtocol: Identifiable {
    var id: String { get }
}

/// Identifiable conformance implementation
extension RoutesProtocol {
    var id: String {
        return UUID().uuidString
    }
}

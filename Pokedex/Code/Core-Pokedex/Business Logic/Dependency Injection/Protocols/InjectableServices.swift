//
//  InjectableServices.swift
//  Pokedex
//
//  Created by Justin Cook on 2/13/23.
//

import Foundation

/// Protocol that allows the deployment of case specific services within any instance that calls this protocol and selectively injects the necessary services to use within that scope
protocol InjectableServices {}

/// All dependency injectable services are listed below, from these implementations these services can be injected into any Instance without the host scope knowing how to instantiate them
extension InjectableServices {
    // MARK: - Networking Service / Monitor
    static func inject() -> NetworkingService {
        return .shared
    }
    
    // MARK: - Apollo GraphQL Service
    static func inject() -> PokedexApolloService {
        return .shared
    }
}

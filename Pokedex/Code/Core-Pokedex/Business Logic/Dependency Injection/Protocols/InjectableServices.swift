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
    
    // MARK: - Apollo GraphQL Service Adapter
    static func inject() -> ApolloGraphQLServiceAdapter {
        return .init()
    }
    
    static func inject() -> ImageDownloaderService {
        return .init()
    }
}


protocol InjectableDataProviders {}

/// Allows easy access of data providers from a single source of truth
extension InjectableDataProviders {
    // MARK: - Remote: Pokemon Data Provider
    static func inject() -> PokemonDataProvider {
        return .shared
    }
}

/// Allows easy access of data stores from a single source of truth
protocol InjectableStores {}

extension InjectableStores {
    // MARK: - Pokemon Store / Responsible for persisting all pokemon data
    static func inject() -> PokemonDataStore {
        return .shared
    }
}


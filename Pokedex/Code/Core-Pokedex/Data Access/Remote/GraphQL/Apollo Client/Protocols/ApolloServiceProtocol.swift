//
//  ApolloServiceProtocol.swift
//  Pokedex
//
//  Created by Justin Cook on 2/13/23.
//

import Apollo

protocol ApolloServiceProtocol {
    /// Singleton for sharing gql data layer across the application consistently
    static var shared: PokedexApolloService { get }
    var client: ApolloClient! { get }
}

//
//  PokemonDataProvider.swift
//  Pokedex
//
//  Created by Justin Cook on 2/13/23.
//

import SwiftUI
import Combine
import Apollo

/// Provides transformed Pokemon data directly to any listeners to be consumed and or stored
class PokemonDataProvider: ObservableObject {
    // MARK: - Properties
    static let shared: PokemonDataProvider = .init()
    
    // MARK: - Published
    @Published private(set) var minimalPokemonModels: [MinimalPokemonModel] = []
    
    // MARK: - Dependencies
    struct Dependencies: InjectableServices {
        let apolloGQLServiceAdapter: ApolloGraphQLServiceAdapter = inject()
    }
    let dependencies = Dependencies()
    
    private init() {
        setup()
    }
    
    func setup() {
        load()
    }
    
    // MARK: - State Management
    func load() {
        fetchAllPokemon()
    }
    
    func reload() {
        load()
    }
    
    func fetchStatsForPokemon(pokemonID: Int,
                              completion: @escaping ((DetailedPokemonModel?) -> Void))
    {
        Task(priority: .high) {
            do {
                dependencies
                    .apolloGQLServiceAdapter
                    .performGetStatsForPokemonQuery(pokemonID: pokemonID) {
                        completion($0)
                    }
            }
        }
    }
    
    // MARK: - Fetching transformed models from Apollo GQL Service Adapter
    func fetchAllPokemon() {
        Task(priority: .high) {
            do {
                dependencies
                    .apolloGQLServiceAdapter
                    .performGetAllPokemonQuery { [weak self] in
                        guard let self = self
                        else { return }
                        
                        self.minimalPokemonModels = $0
                    }
            }
        }
    }
}

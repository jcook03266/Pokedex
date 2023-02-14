//
//  ApolloGraphQLServiceAdapter.swift
//  Pokedex
//
//  Created by Justin Cook on 2/13/23.
//

import Apollo
import Foundation

final class ApolloGraphQLServiceAdapter {
    // MARK: - Properties
    let schema = PokemonSchema.self
    
    /// Keep track of all queries
    enum QueryType: String {
        case getAllPokemon
        case getSpecificPokemonStats
        case getSpecificPokemonSprites
    }
    
    // MARK: - Dependencies
    struct Dependencies: InjectableServices {
        let apolloGQLService: PokedexApolloService = inject()
    }
    internal let dependencies = Dependencies()
    
    init() {}
    
    // MARK: - Queries
    /// Returns all pokemon with minimal fields
    func performGetAllPokemonQuery(
        completion: @escaping (([MinimalPokemonModel]) -> Void)
    ) {
        let query = self
            .schema
            .GetAllPokemonQuery()
        
        dependencies
            .apolloGQLService
            .performQuery(query: query) { result in
                guard let result = result
                else {
                    completion([])
                    return
                }
                
                let pokemon: [MinimalPokemonModel] = result.pokemon.map {
                    MinimalPokemonModel(element: $0)
                }
                
                completion(pokemon)
            }
    }
    
    /// Returns a specific pokemon with maximal fields
    func performGetStatsForPokemonQuery(
        pokemonID: Int,
        completion: @escaping ((DetailedPokemonModel?) -> Void)
    ) {
        let query = self
            .schema
            .GetStatsForPokemonQuery(id: GraphQLNullable<Int>(integerLiteral: pokemonID))
        
        dependencies
            .apolloGQLService
            .performQuery(query: query) { result in
                guard let result = result,
                      let pokemon = result.pokemon.first
                else {
                    completion(nil)
                    return
                }
                
                let detailedPokemon: DetailedPokemonModel = .init(element: pokemon)
                
                completion(detailedPokemon)
            }
    }
}

//
//  Apollo.swift
//  Pokedex
//
//  Created by Justin Cook on 2/13/23.
//

import Apollo

/// Apollo GraphQL API Gateway
class Apollo {
    // MARK: - Properties
    /// API Playground: https://studio.apollographql.com/public/poke-gql/explorer?variant=current
    private let pokemonGraphQLServerEndpoint = "https://beta.pokeapi.co/graphql/v1beta"
    
    static let shared = Apollo()
    
    let client: ApolloClient
    
    
    init() {
        /// Ensure that the server endpoint is a valid, it's necessary for the functionality of the application
        guard let serverEndpoint = pokemonGraphQLServerEndpoint.asURL
        else {
            ErrorCodeDispatcher
            .SwiftErrors
            .triggerPreconditionFailure(for: .urlCouldNotBeParsed,
                                        using: "URL: \(pokemonGraphQLServerEndpoint) in: \(#file) caller: \(#function)")()
        }
        
        self.client = ApolloClient(url: serverEndpoint)
    }
    
    func loadData() {
        let query = PokemonSchema.SamplePokeAPIqueryQuery()
        
        Apollo.shared.client.fetch(query: query) { result in
         
            switch result {
              case .success(let graphQLResult):
                if let pokemon = graphQLResult.data?.gen3_species.compactMap({ $0 }) {
                    print(pokemon)
                }
                    
              case .failure(let error):
                // 5
                print("Error loading data \(error)")
              }
        }
    }
}

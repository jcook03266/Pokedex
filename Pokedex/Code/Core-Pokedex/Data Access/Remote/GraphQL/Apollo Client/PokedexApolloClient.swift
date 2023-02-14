//
//  PokedexApolloClient.swift
//  Pokedex
//
//  Created by Justin Cook on 2/13/23.
//

import Apollo

/// Apollo GraphQL API Gateway
class PokedexApolloService: ApolloServiceProtocol {
    // MARK: - Properties
    /// API Playground: https://studio.apollographql.com/public/poke-gql/explorer?variant=current
    private let pokemonGraphQLServerEndpoint = "https://beta.pokeapi.co/graphql/v1beta"
    
    static let shared: PokedexApolloService = .init()
    var client: ApolloClient!
    
    private init() {
        configure()
    }
    
    func configure() {
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
    
    func performQuery<T: GraphQLQuery>(
        query: T,
        completion: @escaping (T.Data?) -> Void
    ) {
        client.fetch(query: query) { [weak self] result in
            guard let self = self
            else {
                completion(nil)
                return
            }
            
            Task {
                do {
                    let fetchedData = try await self.handleResult(for: query,
                                                                    result: result).get()
                    
                    completion(fetchedData)
                }
            }
        }
    }
    
    func handleResult<T: GraphQLOperation>(
        for operationType: T,
        result: Result<GraphQLResult<T.Data>, Error>
    ) async -> Result<T.Data?, Error> {
        switch result {
        case .success(let gqlResult):
            var errorMessages: [String] = []
            if let errors = gqlResult.errors,
               !errors.isEmpty {
                errorMessages = errors.compactMap({ $0.errorDescription })
            }
            
            if let data = gqlResult.data {
                return .success(data)
            }
            else {
                return .failure(
                    ErrorCodeDispatcher
                        .GraphQLErrors
                        .throwError(for: .resultHandlingError(operation: operationType,
                                                              errors: errorMessages)))
            }
            
        case .failure(let error):
            return .failure(
                ErrorCodeDispatcher
                    .GraphQLErrors
                    .throwError(for: .resultHandlingError(operation: operationType,
                                                          errors: [error.localizedDescription])))
        }
    }
    
    func loadData() {
        let query = PokemonSchema.GetAllPokemonQuery()
        
        self.performQuery(query: query) { fetchedData in
            if let pokemon = fetchedData?.pokemon {
                print(pokemon)
            }
        }
    }
}

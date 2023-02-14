//
//  PokemonDataProvider.swift
//  Pokedex
//
//  Created by Justin Cook on 2/13/23.
//

import SwiftUI
import Combine

class PokemonDataProvider {
    static let shared: PokemonDataProvider = .init()
    
    // MARK: - Dependencies
    struct Dependencies: InjectableServices {
        let networkingService: NetworkingService = inject()
        let apolloGQLService: PokedexApolloService = inject()
    }
    let dependencies = Dependencies()
    
    init() {
        
    }
}

//
//  AppService.swift
//  Pokedex
//
//  Created by Justin Cook on 2/14/23.
//

import SwiftUI
import Combine

/** Singleton centralized service that stands as the reference point for this application*/
open class AppService: ObservableObject {
    static let shared: AppService = .init()

    // MARK: - Debug Environment Properties
    static let isDebug: Bool = false
    
    // MARK: - Dependencies
    struct Dependencies: InjectableServices {
        let networkingService: NetworkingService = inject()
    }
    var dependencies = Dependencies()

    // MARK: - Data Providers
    struct DataProviders: InjectableDataProviders {
        let pokemonDataProvider: PokemonDataProvider = inject()
    }
    var dataProviders = DataStores()
    
    // MARK: - Data Stores
    struct DataStores: InjectableStores {
        let pokemonDataStore: PokemonDataStore = inject()
    }
    var dataStores = DataStores()
    
    private init() {}
}

//
//  PokemonDataStore.swift
//  Pokedex
//
//  Created by Justin Cook on 2/13/23.
//

import Foundation
import Combine

class PokemonDataStore: ObservableObject {
    // MARK: - Published
    @Published private(set) var detailedPokemonModelCache: [DetailedPokemonModel] = []
    @Published private(set) var minimalPokemonModels: [MinimalPokemonModel] = []
    
    // Searching / Filtering
    /// The current query being used to filter the store's data pool
    @Published var activeSearchQuery: String = ""
    @Published var activePokemonTypeFilter: PokemonType? = nil
    @Published var searchResultCount: Int = 0
    
    // MARK: - Properties
    /// If the amount of cached detailed pokemon models exceeds this limit then the oldest element is evicted from the cache (FIFO Queue)
    private let maxDetailedPokemonModelCacheSize: Int = 10
    let dataProvider: PokemonDataProvider = .shared
    
    // MARK: - Singleton
    static let shared: PokemonDataStore = .init()
    
    // MARK: - Subscriptions
    private var cancellables: Set<AnyCancellable> = []
    private let scheduler: DispatchQueue = DispatchQueue.main
    private let debounceInterval: Double = 0.25
    
    // MARK: - Convenience
    private var isDetailedPokemonModelCacheFull: Bool {
        return detailedPokemonModelCache.count > maxDetailedPokemonModelCacheSize
    }
    
    var isDataLoaded: Bool {
        return !dataProvider.minimalPokemonModels.isEmpty
    }

    var pokemonCount: Int {
        return minimalPokemonModels.count
    }
    
    private init() {
        setup()
    }
    
    func setup() {
       subscribeToProvider()
    }
    
    func subscribeToProvider() {
        $activePokemonTypeFilter
            .combineLatest(dataProvider.$minimalPokemonModels)
            .map(filterByType)
            .combineLatest($activeSearchQuery)
            .debounce(for: .seconds(debounceInterval),
                      scheduler: scheduler)
            .map(filter)
            .assign(to: &$minimalPokemonModels)
    }
    
    // MARK: - Store mutation and accessor methods
    func refresh() {
        dataProvider
            .reload()
    }
    
    func getDetailedPokemonModel(with id: Int,
                                 completion: @escaping ((DetailedPokemonModel?) -> Void))
    {
        var detailedPokemonModel: DetailedPokemonModel? = nil
        /// Check cache first
        detailedPokemonModel = detailedPokemonModelCache.first { $0.element.id == id }
        
        /// Fetch from data provider
        if detailedPokemonModel == nil {
            dataProvider
                .fetchStatsForPokemon(pokemonID: id) { [weak self] in
                    guard let self = self,
                          let pokemon = $0
                    else {
                        completion($0)
                        return
                    }
                    
                    self.addPokemonToCache(pokemon: pokemon)
                    
                    if self.isDetailedPokemonModelCacheFull {
                        self.evictOldestCachedDetailedPokemon()
                    }
                    
                    completion(pokemon)
                }
        }
        else {
            completion(detailedPokemonModel)
        }
    }
    
    // MARK: - Filtering
    private func filterByType(using type: PokemonType?,
                        on unfilteredPokemon: [MinimalPokemonModel]) -> [MinimalPokemonModel]
    {
        guard let type = type
        else { return unfilteredPokemon }
        
        let filteredPokemon = unfilteredPokemon.filter { pokemon -> Bool in
            let pokemon = pokemon.element
            let pokemonTypes = pokemon.types.compactMap({ PokemonType(rawValue: $0.pokemon_v2_type?.pokemonType ?? PokemonType.bug.rawValue) })
            
            let condition = pokemonTypes.contains(type)
            
            return condition
        }
        
        return filteredPokemon
    }
    
    private func filter(unfilteredPokemon: [MinimalPokemonModel],
                        using query: String) -> [MinimalPokemonModel]
    {
        guard !query.isEmpty else { return unfilteredPokemon }
        
        // To accurately compare the model's identifier strings with the given query, all strings have to be lowercased
        let lowercasedQuery = query.lowercased()
        
        // If a pokemon satisfies the specified predicate then it is returned in the local filtered array of pokemon
        let filteredPokemon = unfilteredPokemon.filter { (pokemon) -> Bool in
            let pokemon = pokemon.element
            let pokemonTypes = pokemon.types.compactMap({ $0.pokemon_v2_type?.pokemonType })
            let pokemonColor = PokemonColors.init(rawValue: pokemon.speciesColorID?.id ?? 1) ?? .black
            let pokemonColorName = PokemonColors.getColorLiteralName(from: pokemonColor)
            
            /// Filters based on name, id, types, and color
            let condition = pokemon.name.lowercased().contains(lowercasedQuery) ||
            pokemon.id.description.contains(lowercasedQuery) ||
            pokemonTypes.contains(where: { $0.contains(lowercasedQuery)}) ||
            pokemonColorName.contains(lowercasedQuery)
            
            return condition
        }
        
        searchResultCount = filteredPokemon.count
        
        return filteredPokemon
    }
    
    private func addPokemonToCache(pokemon: DetailedPokemonModel) {
        guard !isDetailedPokemonModelCacheFull
        else { return }
        
        detailedPokemonModelCache.append(pokemon)
    }
    
    private func evictOldestCachedDetailedPokemon() {
        guard isDetailedPokemonModelCacheFull
        else { return }
        
        detailedPokemonModelCache.removeFirst()
    }
}

//
//  PokemonDataStore.swift
//  Pokedex
//
//  Created by Justin Cook on 2/13/23.
//

import Foundation

class PokemonDataStore: ObservableObject {
    // MARK: - Published
    @Published private(set) var detailedPokemonModelCache: [DetailedPokemonModel] = []
    @Published private(set) var minimalPokemonModels: [MinimalPokemonModel] = []
    
    // MARK: - Properties
    /// If the amount of cached detailed pokemon models exceeds this limit then the oldest element is evicted from the cache (FIFO Queue)
    private let maxDetailedPokemonModelCacheSize: Int = 10
    private let dataProvider: PokemonDataProvider = .shared
    static let shared: PokemonDataStore = .init()
    
    // MARK: - Convenience
    private var isDetailedPokemonModelCacheFull: Bool {
        return detailedPokemonModelCache.count > maxDetailedPokemonModelCacheSize
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

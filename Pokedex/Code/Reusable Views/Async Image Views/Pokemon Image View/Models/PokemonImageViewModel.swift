//
//  PokemonImageViewModel.swift
//  Pokedex
//
//  Created by Justin Cook on 2/14/23.
//

import SwiftUI
import Combine

class PokemonImageViewModel: GenericViewModel {
    // MARK: - Published
    @Published var image: UIImage? = nil
    /// Used to determine the current state of the async loading of the specified image asset
    @Published var isLoading: Bool = true
    
    // MARK: - Observed
    @ObservedObject var pokemonImageFetcher: PokemonImageFetcher
    
    // MARK: Properties
    private let pokemonModel: MinimalPokemonModel
    
    init(pokemonModel: MinimalPokemonModel) {
        self.pokemonModel = pokemonModel
        self.pokemonImageFetcher = PokemonImageFetcher(pokemonModel: pokemonModel)
        
        getImage()
    }
    
    private func getImage() {
        pokemonImageFetcher
            .getImage { [weak self] fetchedImage in
            guard let self = self else { return }
            
            self.image = fetchedImage
            self.isLoading = false
        }
    }
}


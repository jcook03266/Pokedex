//
//  PokemonGridViewModel.swift
//  Pokedex
//
//  Created by Justin Cook on 2/14/23.
//

import SwiftUI

class PokemonGridViewModel: GenericViewModel {
    typealias Pokemon = PokemonSchema.GetAllPokemonQuery.Data.Pokemon
    
    // MARK: - Properties
    var router: MainRouter
    var minimalPokemonModel: MinimalPokemonModel
    
    // MARK: - Styling
    // Colors
    var backgroundColor: Color {
        let colorID: Int = pokemon
            .speciesColorID?
            .id ?? 1
        
        let pokemonColor: PokemonColors = .init(rawValue: colorID) ?? .black
        
        return Colors.getColorFor(pokemonColor: pokemonColor)
    }
    
    let pokemonTypeChipletBackgroundColor: Color = Colors.permanent_white.0.opacity(0.25),
orderTextColor: Color = Colors.black_45.0,
        nameTextColor: Color = Colors.permanent_white.0,
        typeTextColor: Color = Colors.permanent_white.0,
        shadowColor: Color = Colors.shadow_1.0,
        backgroundArtColor: Color = Colors.permanent_white.0.opacity(0.25)
    
    // Fonts
    let nameFont: FontRepository = .body_M_Bold,
        pokemonTypeFont: FontRepository = .body_XS,
        pokemonOrderFont: FontRepository = .body_S_Bold
    
    // MARK: - Assets
    /// Images
    let backgroundArt: Image = Images.getImage(named: .pokemon_ball_backdrop)
    
    // MARK: - Text
    var pokemonName: String {
        return pokemon
            .name
            .capitalized
    }
    
    var pokemonID: Int {
        return pokemon.id
    }
    
    var pokemonIDNumber: String {
        if pokemonID < 10 {
            return "#00\(pokemonID)"
        }
        else if pokemonID < 100 {
            return "#0\(pokemonID)"
        }
        
        return "#\(pokemonID)"
    }
    
    var pokemonTypes: [String] {
        return pokemon.types.compactMap {
            $0.pokemon_v2_type?
                .pokemonType.capitalized
        }
    }
    
    // MARK: - Convenience
    var pokemon: Pokemon {
        return minimalPokemonModel.element
    }
    
    init(router: MainRouter,
         pokemon: MinimalPokemonModel)
    {
        self.router = router
        self.minimalPokemonModel = pokemon
    }
}

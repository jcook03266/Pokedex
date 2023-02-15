//
//  PokemonTypeSelectionChipViewModel.swift
//  Pokedex
//
//  Created by Justin Cook on 2/15/23.
//

import SwiftUI
import Combine

class PokemonTypeSelectionChipViewModel: GenericViewModel, Hashable, Equatable {
    // MARK: - Publishers
    @Published var isSelected: Bool = false
    
    // MARK: - Properties
    let id: UUID = .init(),
        action: (() -> Void),
        label: String,
        pokemonType: PokemonType
    
    // MARK: - Styling
    // Colors
    var backgroundColor: Color {
        return isSelected ? Colors.neutral_800.0 : Colors.neutral_300.0
    }
    var shadowColor: Color {
        return isSelected ? Colors.shadow_1.0 : .clear
    }
    let foregroundColor: Color = Colors.white.0
    
    // Fonts
    let font: FontRepository = .body_XS,
        fontWeight: Font.Weight = .semibold
    
    // MARK: - Protocol Conformance
    static func == (lhs: PokemonTypeSelectionChipViewModel,
                    rhs: PokemonTypeSelectionChipViewModel) -> Bool
    {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(label)
    }
    
    init(isSelected: Bool,
         pokemonType: PokemonType,
         action: @escaping () -> Void,
         label: String)
    {
        self.isSelected = isSelected
        self.action = action
        self.label = label
        self.pokemonType = pokemonType
    }
}

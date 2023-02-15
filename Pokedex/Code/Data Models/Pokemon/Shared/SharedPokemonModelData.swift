//
//  SharedPokemonModelData.swift
//  Pokedex
//
//  Created by Justin Cook on 2/13/23.
//

import Foundation
import SwiftUI

enum PokemonType: String, Codable, CaseIterable {
    case bug = "bug"
    case dark = "dark"
    case dragon = "dragon"
    case electric = "electric"
    case fairy = "fairy"
    case fighting = "fighting"
    case fire = "fire"
    case flying = "flying"
    case ghost = "ghost"
    case grass = "grass"
    case ground = "ground"
    case ice = "ice"
    case normal = "normal"
    case poison = "poison"
    case psychic = "psychic"
    case rock = "rock"
    case steel = "steel"
    case water = "water"
}

enum PokemonColors: Int, Codable {
    case black = 1
    case blue = 2
    case brown = 3
    case gray = 4
    case green = 5
    case pink = 6
    case purple = 7
    case red = 8
    case white = 9
    case yellow = 10
    
    static var random: PokemonColors {
        return PokemonColors(rawValue: Int.random(in: 1...10)) ?? .black
    }
    
    static var randomColor: Color {
        return Colors.getColorFor(pokemonColor: random)
    }
    
    /// - Returns: A string description of the selected color enum instead of an int raw value
    static func getColorLiteralName(from color: PokemonColors) -> String {
        switch color {
        case .black:
            return "black"
        case .blue:
            return "blue"
        case .brown:
            return "brown"
        case .gray:
            return "gray"
        case .green:
            return "green"
        case .pink:
            return "pink"
        case .purple:
            return "purple"
        case .red:
            return "red"
        case .white:
            return "white"
        case .yellow:
            return "yellow"
        }
    }
}

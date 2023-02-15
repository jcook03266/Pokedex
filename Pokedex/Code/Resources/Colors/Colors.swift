//
//  Colors.swift
//  Pokedex
//
//  Created by Justin Cook on 2/14/23.
//

import Foundation
import SwiftUI
import UIKit

/// Simplified and organized way of referencing the colors stored in the Colors assets directory
// MARK: - Structs
struct Colors {
    static func getColor(named colorName: ColorRepository) -> Color {
        let color = Color(getUIColor(named: colorName))
        
        return color
    }
    
    static func getUIColor(named colorName: ColorRepository) -> UIColor {
        guard let uiColor = UIColor(named: colorName.rawValue) else {
            preconditionFailure("Error: The color named \(colorName) was not found, Function: \(#function)")
        }
        
        return uiColor
    }
    
    static func getUIColors(named color1: ColorRepository, color2: ColorRepository) -> (UIColor, UIColor) {
        guard let uiColor1 = UIColor(named: color1.rawValue),
                let uiColor2 = UIColor(named: color2.rawValue) else {
            preconditionFailure("Error: One of the colors named [\(color1), \(color2)] were not found, Function: \(#function)")
        }

        return (uiColor1, uiColor2)
    }
    
    static func getColors(named color1: ColorRepository, color2: ColorRepository) -> (Color, Color) {
        let uiColors = getUIColors(named: color1, color2: color2)

        return (Color(uiColors.0), Color(uiColors.1))
    }
    
    static func getColors(named colors: [ColorRepository]) -> [Color] {
        var uiColors: [Color] = [Color]()
        
        for color in colors {
            let color = Color(getUIColor(named: color))
            uiColors.append(color)
        }

        return uiColors
    }
    
    // Colors
    static var black: (Color, UIColor) {
        return (getColor(named: .black), getUIColor(named: .black))
    }
    static var neutral_900: (Color, UIColor) {
        return (getColor(named: .neutral_900), getUIColor(named: .neutral_900))
    }
    static var neutral_800: (Color, UIColor) {
        return (getColor(named: .neutral_800), getUIColor(named: .neutral_800))
    }
    static var neutral_700: (Color, UIColor) {
        return (getColor(named: .neutral_700), getUIColor(named: .neutral_700))
    }
    static var neutral_600: (Color, UIColor) {
        return (getColor(named: .neutral_600), getUIColor(named: .neutral_600))
    }
    static var neutral_500: (Color, UIColor) {
        return (getColor(named: .neutral_500), getUIColor(named: .neutral_500))
    }
    static var neutral_400: (Color, UIColor) {
        return (getColor(named: .neutral_400), getUIColor(named: .neutral_400))
    }
    static var neutral_300: (Color, UIColor) {
        return (getColor(named: .neutral_300), getUIColor(named: .neutral_300))
    }
    static var neutral_200: (Color, UIColor) {
        return (getColor(named: .neutral_200), getUIColor(named: .neutral_200))
    }
    static var neutral_100: (Color, UIColor) {
        return (getColor(named: .neutral_100), getUIColor(named: .neutral_100))
    }
    static var white: (Color, UIColor) {
        return (getColor(named: .white), getUIColor(named: .white))
    }
    static var attention: (Color, UIColor) {
        return (getColor(named: .attention), getUIColor(named: .attention))
    }
    static var shadow_1: (Color, UIColor) {
        return (getColor(named: .shadow_1), getUIColor(named: .shadow_1))
    }

    // Opaque Colors
    // Black with an opacity of 45%
    static var black_45: (Color, UIColor) {
        return (getColor(named: .black_45), getUIColor(named: .black_45))
    }
    static var backdrop: (Color, UIColor) {
        return (getColor(named: .backdrop), getUIColor(named: .backdrop))
    }
    
    // Permanent Colors (Don't change w/ environment attributes)
    static var permanent_white: (Color, UIColor) {
        return (getColor(named: .permanent_white), getUIColor(named: .permanent_white))
    }
    static var permanent_black: (Color, UIColor) {
        return (getColor(named: .permanent_black), getUIColor(named: .permanent_black))
    }
    
    static func getColorFor(pokemonColor: PokemonColors) -> Color {
        switch pokemonColor {
        case .black:
            return Colors.getColor(named: .pokemon_black)
        case .blue:
            return Colors.getColor(named: .pokemon_blue)
        case .brown:
            return Colors.getColor(named: .pokemon_brown)
        case .gray:
            return Colors.getColor(named: .pokemon_gray)
        case .green:
            return Colors.getColor(named: .pokemon_green)
        case .pink:
            return Colors.getColor(named: .pokemon_pink)
        case .purple:
            return Colors.getColor(named: .pokemon_purple)
        case .red:
            return Colors.getColor(named: .pokemon_red)
        case .white:
            return Colors.getColor(named: .pokemon_white)
        case .yellow:
            return Colors.getColor(named: .pokemon_yellow)
        }
    }
}

// MARK: Colors
enum ColorRepository: String, CaseIterable, Codable, Hashable {
    case black, neutral_900, neutral_800, neutral_700, neutral_600, neutral_500, neutral_400, neutral_300, neutral_200, neutral_100, white, attention, shadow_1, text_black, text_white, permanent_white, permanent_black, black_45, backdrop,
         pokemon_black, pokemon_blue, pokemon_brown,
         pokemon_gray, pokemon_green, pokemon_pink,
         pokemon_purple, pokemon_red, pokemon_white,
         pokemon_yellow
}

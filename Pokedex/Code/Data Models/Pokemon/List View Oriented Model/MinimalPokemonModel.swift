//
//  MinimalPokemonModel.swift
//  Pokedex
//
//  Created by Justin Cook on 2/13/23.
//

import Foundation
import Apollo

struct MinimalPokemonModel {
    let element: PokemonSchema.GetAllPokemonQuery.Data.Pokemon
}

extension MinimalPokemonModel {
    // MARK: - For lazy loading purposes, returns static data
    static func getMockData() -> MinimalPokemonModel {
        
        let jsonObject: JSONObject = [
            "name": "bulbasaur",
            "id": Int(1),
            "types": [
              [
                "pokemon_v2_type": [
                  "pokemonType": "grass"
                ]
              ],
              [
                "pokemon_v2_type": [
                  "pokemonType": "poison"
                ]
              ]
            ],
            "speciesColorID": [
              "id": 5
            ]
        ]
 
        let pokemon = PokemonSchema
            .GetAllPokemonQuery
            .Data
            .Pokemon
            .init(data: .init(jsonObject, variables: [:]))
   
        return MinimalPokemonModel(element: pokemon)
    }
}

//
//  PokedexApp.swift
//  Pokedex
//
//  Created by Justin Cook on 2/13/23.
//

import SwiftUI
import Foundation
import ObjectiveC

@main
struct PokedexApp: App {
    // MARK: - Observed
    @StateObject var rootCoordinatorDelegate: RootCoordinatorDelegate = .shared
    
    // MARK: - Convenience variables
    var activeRootCoordinator: any RootCoordinator {
        return rootCoordinatorDelegate.activeRootCoordinator!
    }
    
    var body: some Scene {
        WindowGroup {
            Group {
                activeRootCoordinator.coordinatorView()
            }
            .onAppear {
                onLoadTasks()
            }
        }
    }
    
    func onLoadTasks() {
        let helper = WeightConversionHelper()
        let helperManager = HelperManager()
        
       
        
        print(helperManager.lengthConverter.convertFeet(toSpeciallyFormattedString: 6.6))

        
        print(helperManager.weightConverter.convertKg(toPoundsFormattedString: 100))
        
//        PokemonDataProvider
//            .shared
//            .fetchStatsForPokemon(pokemonID: 1) { pokemon in
//
//                guard let pokemon = pokemon
//                else { return }
//
//                print(pokemon)
//                print(pokemon.element.name)
//            }
    }
}

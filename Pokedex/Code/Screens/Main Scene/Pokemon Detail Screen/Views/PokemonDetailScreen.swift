//
//  PokemonDetailScreen.swift
//  Pokedex
//
//  Created by Justin Cook on 2/14/23.
//

import SwiftUI

struct PokemonDetailScreen: View {
    // MARK: - Observed
    @StateObject var model: PokemonDetailScreenViewModel
    
    var body: some View {
        Group {
            if let pokemon = model.selectedPokemon {
                Text(pokemon.element.name.description)
            }
            else {
                Text("Loading")
            }
        }
    }
}

struct PokemonDetailScreen_Previews: PreviewProvider {
    static func getModel() -> PokemonDetailScreenViewModel {
        let coordinator: MainCoordinator = RootCoordinatorDispatcher(delegate: .shared).getRootCoordinatorFor(root: .mainCoordinator) as! MainCoordinator
        
        coordinator
            .router
            .currentlySelectedPokemonID = 4
        
        let model: PokemonDetailScreenViewModel = .init(coordinator: coordinator,
                                                        router: coordinator.router)
        
        return model
    }
    
    static var previews: some View {
        PokemonDetailScreen(model: getModel())
    }
}

//
//  PokemonDetailScreenViewModel.swift
//  Pokedex
//
//  Created by Justin Cook on 2/13/23.
//

import SwiftUI
import Combine

class PokemonDetailScreenViewModel: GenericViewModel {
    typealias coordinator = MainCoordinator
    typealias router = MainRouter
    
    // MARK: - Properties
    var coordinator: coordinator
    var router: router
    let pokemonDataStore: PokemonDataStore = .shared
    
    // MARK: - Published
    @Published private var selectedPokemonID: Int? = nil
    @Published var selectedPokemon: DetailedPokemonModel? = nil
    
    // MARK: - Subscription
    var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Styling
    // Colors
//    let backgroundColor: Color = Color.clear,
//        foregroundContainerColor: Color = Colors.neutral_100.0,
//        titleForegroundColor: Color = Colors.permanent_white.0,
//        titleIconForegroundColor: Color = Colors.permanent_white.0
    
    // Fonts
//    let titleFont: FontRepository = .heading_2,
//        titleFontWeight: Font.Weight = .semibold
    
    // MARK: - Assets
    /// Images
   // let titleIcon: Image = Icons.getIconImage(named: .gear)
    
    // MARK: - Localized Text
//    let title: String = LocalizedStrings.getLocalizedString(for: .SETTINGS_SCREEN_TITLE)
    
    init(coordinator: coordinator,
         router: router) {
        self.coordinator = coordinator
        self.router = router
        
        addSubscribers()
    }
    
    func addSubscribers() {
        self.router
            .$currentlySelectedPokemonID
            .sink { [weak self] in
                guard let self = self,
                      let id = $0
                else { return }
                
                self.selectedPokemonID = id
                self.getSelectedPokemonData()
            }
            .store(in: &cancellables)
    }
    
    private func getSelectedPokemonData() {
        guard let selectedPokemonID = selectedPokemonID
        else { return }
        
        pokemonDataStore.getDetailedPokemonModel(with: selectedPokemonID) { [weak self] in
            guard let self = self
            else { return }
            
            self.selectedPokemon = $0
        }
    }
}

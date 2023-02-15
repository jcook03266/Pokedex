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
    typealias detailedPokemon = PokemonSchema.GetStatsForPokemonQuery.Data.Pokemon
    typealias lowLODPokemon = PokemonSchema.GetAllPokemonQuery.Data.Pokemon
    
    // MARK: - Properties
    var coordinator: coordinator
    var router: router
    let pokemonDataStore: PokemonDataStore = .shared
    
    // MARK: - Published
    @Published var detailedSelectedPokemon: DetailedPokemonModel? = nil
    @Published var selectedPokemon: MinimalPokemonModel
    
    // MARK: - Subscription
    var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Helpers
    var unitHelpers: HelperManager = .init()
    
    // MARK: - Styling
    // Colors
    var heroBackgroundColor: Color {
        let colorID: Int = lessDetailedPokemon
            .speciesColorID?
            .id ?? 1
        
        let pokemonColor: PokemonColors = .init(rawValue: colorID) ?? .black
        
        return Colors.getColorFor(pokemonColor: pokemonColor)
    }
    
    let backgroundColor: Color = Colors.white.0,
        foregroundContainerColor: Color = Colors.neutral_100.0,
        titleForegroundColor: Color = Colors.permanent_white.0,
        titleIconForegroundColor: Color = Colors.permanent_white.0,
        nameTextColor: Color = Colors.permanent_white.0,
        typeTextColor: Color = Colors.permanent_white.0,
        shadowColor: Color = Colors.shadow_1.0,
        backgroundArtColor: Color = Colors.permanent_white.0.opacity(0.25),
        pokemonTypeChipletBackgroundColor: Color = Colors.permanent_white.0.opacity(0.25),
        orderTextColor: Color = Colors.permanent_white.0,
        infoSectionHeaderTextColor: Color = Colors.neutral_500.0,
        infoSectionTextColor: Color = Colors.black.0,
        infoSectionTitleFontColor: Color = Colors.black.0
    
    // Fonts
    let nameFont: FontRepository = .heading_2,
        pokemonTypeFont: FontRepository = .body_2XS_Bold,
        pokemonOrderFont: FontRepository = .body_L_Bold,
        infoSectionHeaderFont: FontRepository = .body_M_Bold,
        infoSectionFont: FontRepository = .body_M,
infoSectionFontWeight: Font.Weight = .semibold,
        infoSectionTitleFont: FontRepository = .body_XL_Bold
    
    // MARK: - Assets
    /// Images
    let backgroundArt: Image = Images.getImage(named: .pokemon_ball_backdrop),
        backgroundArt_2: Image = Images.getImage(named: .pokemon_ball_art_filled),
        backgroundArt_3: Image = Images.getImage(named: .pokemon_ball_art),
        backButtonIcon: Image = Icons.getIconImage(named: .arrow_left)
    
    // MARK: - Localized Text
    //    let title: String = LocalizedStrings.getLocalizedString(for: .SETTINGS_SCREEN_TITLE)
    
    // MARK: Text
    var pokemonName: String {
        return lessDetailedPokemon
            .name
            .capitalized
    }
    
    var pokemonSpecies: String {
        return (pokemon?
            .pokemon_v2_pokemonspecy?
            .name
                ?? "N/A").capitalized
            
    }
    
    var pokemonHeight: String {
        /// The height is supposed to be multiplied by 10
        let pokemonHeight = (Float(pokemon?.height ?? 0) * 10)
        
        let heightInFeet = unitHelpers
            .lengthConverter
            .convertCm(toFeet: Float(pokemonHeight))
        
        let heightInCMString = unitHelpers
            .lengthConverter
            .convertLength(toFormattedString: Float(pokemonHeight),
                           to: .centimeters)
        
        let heightInFtString = unitHelpers
            .lengthConverter
            .convertFeet(toSpeciallyFormattedString: heightInFeet)
        
        return "\(heightInFtString) (\(heightInCMString))"
    }
    
    var pokemonWeight: String {
        /// Weight has to be divided by 10 for some reason
        let pokemonWeight = (Float(pokemon?.weight ?? 0) / 10)
        
        let weightInLbsString = unitHelpers
            .weightConverter
            .convertKg(toPoundsFormattedString: Float(pokemonWeight))
        
        let weightInKgsString = unitHelpers
            .weightConverter
            .convertWeight(toFormattedString: Float(pokemonWeight),
                           to: .kilograms)
        
        return "\(weightInLbsString) (\(weightInKgsString))"
    }
    
    var pokemonAbilities: String {
        let pokemonAbilities = pokemon?.pokemon_v2_pokemonabilities
            .compactMap({ $0.pokemon_v2_ability?.name }) ?? []
        
        var abilitiesListString = ""
        
        for (index, ability) in pokemonAbilities.enumerated() {
            abilitiesListString.append(ability.capitalized)
            
            if index != pokemonAbilities.count - 1 {
                abilitiesListString.append(", ")
            }
        }
        
        return abilitiesListString.isEmpty ? "None" : abilitiesListString
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
        return lessDetailedPokemon.types.compactMap {
            $0.pokemon_v2_type?
                .pokemonType.capitalized
        }
    }
    
    // MARK: - Base Stats
    var pokemonStats: [PokemonStats : Int] {
        let stats = pokemon?
            .pokemon_v2_pokemonstats
            .compactMap({
                PokemonStats.init(rawValue: $0.pokemon_v2_stat?.name ?? PokemonStats.attack.rawValue) })
        
        let baseStatValues = pokemon?
            .pokemon_v2_pokemonstats
            .compactMap({ $0.base_stat })
        
        return Dictionary(uniqueKeysWithValues: zip(stats ?? [],
                                             baseStatValues ?? []))
    }
    var pokemonHP: Int {
        return pokemonStats[.hp] ?? 0
    }
    
    var pokemonDefense: Int {
        return pokemonStats[.defense] ?? 0
    }
    
    var pokemonAttack: Int {
        return pokemonStats[.attack] ?? 0
    }
    
    var pokemonSpecialAttack: Int {
        return pokemonStats[.special_attack] ?? 0
    }
    
    var pokemonSpecialDefense: Int {
        return pokemonStats[.special_defense] ?? 0
    }
    
    var pokemonSpeed: Int {
        return pokemonStats[.speed] ?? 0
    }
    
    var pokemonStatsTotal: Int {
        return pokemonStats.reduce(0, { partialResult, next in
            partialResult + next.value
        })
    }
    
    // MARK: - Convenience
    var lessDetailedPokemon: lowLODPokemon {
        return selectedPokemon.element
    }
    
    var pokemon: detailedPokemon? {
        return detailedSelectedPokemon?.element
    }
    
    var pokemonID: Int {
        return lessDetailedPokemon.id
    }
    
    var isLoaded: Bool {
        return pokemon != nil
    }
    
    // MARK: - Actions
    var dismiss: () -> Void {
        return { [weak self] in
            guard let self = self
            else { return }
            
            self.coordinator.dismissFullScreenCover()
        }
    }
    
    init(coordinator: coordinator,
         router: router) {
        self.coordinator = coordinator
        self.router = router
        self.selectedPokemon = .getMockData()
        
        addSubscribers()
    }
    
    func addSubscribers() {
        self.router
            .$currentlySelectedPokemon
            .sink { [weak self] in
                guard let self = self,
                      let pokemon = $0
                else { return }
                
                self.selectedPokemon = pokemon
                self.getSelectedPokemonData()
            }
            .store(in: &cancellables)
    }
    
    private func getSelectedPokemonData() {
        pokemonDataStore.getDetailedPokemonModel(with: pokemonID) { [weak self] in
            guard let self = self
            else { return }
            
            self.detailedSelectedPokemon = $0
        }
    }
}

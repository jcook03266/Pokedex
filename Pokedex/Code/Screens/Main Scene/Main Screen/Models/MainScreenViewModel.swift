//
//  MainScreenViewModel.swift
//  Pokedex
//
//  Created by Justin Cook on 2/13/23.
//

import SwiftUI
import Combine
import Sheathed_TextField_SwiftUI

class MainScreenViewModel: GenericViewModel {
    typealias coordinator = MainCoordinator
    
    // MARK: - Observed
    @ObservedObject var coordinator: coordinator
    
    // MARK: - Published
    @Published var pokemonModels: [MinimalPokemonModel] = []
    @Published var searchResultsCount: Int = 0
    @Published var isSearching: Bool = false
    @Published var currentlySelectedPokemonTypeSelectionChip: PokemonTypeSelectionChipViewModel? = nil
    
    // MARK: - Styling
    // Colors
    let backgroundColor: Color = Colors.white.0,
        backgroundArtColor: Color = Colors.neutral_100.0,
        titleForegroundColor: Color = Colors.black.0,
        searchResultsFontColor: Color = PokemonColors.randomColor
    
    // Fonts
    let titleFont: FontRepository = .heading_2,
        titleFontWeight: Font.Weight = .heavy,
        searchResultsFont: FontRepository = .body_S_Bold
    
    // MARK: - Subscriptions
    private var cancellables: Set<AnyCancellable> = []
    private let scheduler: DispatchQueue = DispatchQueue.main
    private let searchBarDebounceCharacterLimit: Int = 2 // Debounce until the user enters two or more characters to get a more refined search for performance reasons
    
    // MARK: - Data Stores
    struct DataStores: InjectableStores {
        let pokemonDataStore: PokemonDataStore = inject()
    }
    var dataStores = DataStores()
    
    // MARK: - Assets
    /// Images
    let backgroundArt: Image = Images.getImage(named: .pokemon_ball_backdrop)
    
    // MARK: - Localized Text
    let title: String = LocalizedStrings.getLocalizedString(for: .APP_NAME)
    
    // MARK: - Convenience
    var router: MainRouter {
        return self.coordinator
            .router
    }
    
    var userHasSearchQuery: Bool {
        return !searchTextFieldModel.textEntry.isEmpty
    }
    
    var isSearchBarDebounceActive: Bool {
        return searchTextFieldModel.textEntry.count < searchBarDebounceCharacterLimit
    }
    
    // Lazy loading
    /// How many placeholder views to render in the scene when loading data
    var lazyLoadingPlaceholderViewRange: ClosedRange<Int> {
        return 0...10
    }
    
    /// Detect if the data provider doesn't have any data, if so then the data is being loaded
    var isPokedexLoading: Bool {
        return !dataStores
            .pokemonDataStore
            .isDataLoaded
    }
    
    // MARK: - Text
    var searchResultsCountText: String {
        return "\(searchResultsCount) Pokemon Found"
    }
    
    // MARK: - Models
    var searchTextFieldModel: SheathedTextFieldModel!
    var pokemonTypeSelectionChips: [PokemonTypeSelectionChipViewModel] = []
    
    init(coordinator: coordinator) {
        self.coordinator = coordinator
        
        setModels()
        addSubscribers()
    }
    
    func setModels() {
        searchTextFieldModel = .init()
        searchTextFieldModel.configurator { model in
            model.title = "Search Bar"
            model.sheatheColor = PokemonColors.randomColor
            model.iconColor = Colors.permanent_white.0
            model.textColor = Colors.permanent_white.0
            model.fieldBackgroundColor = Colors.white.0
            model.textFieldTextColor = Colors.black.0
            model.placeholderText = "Pikachu I Choose You!"
            model.icon = Icons.getIconImage(named: .magnifyingglass)
            model.keyboardType = .asciiCapable
            model.textContentType = .name
            model.submitLabel = .search
            
            model.inFieldButtonIconTint = model.sheatheColor
            model.inFieldButtonIcon = Icons.getIconImage(named: .arrow_counterclockwise)
            model.inFieldButtonAction = {
                model.textEntry.clear()
            }
            
            model.onSubmitAction = {
                model.unsheathed = false
            }
        }
        
        pokemonTypeSelectionChips = PokemonType.allCases
            .compactMap({
                PokemonTypeSelectionChipViewModel
                .init(isSelected: false,
                      pokemonType: $0,
                      action: {},
                      label: $0.rawValue.capitalized)
            })
    }
    
    func addSubscribers() {
        /// loading all Pokemon
        dataStores
            .pokemonDataStore
            .$minimalPokemonModels
            .receive(on: scheduler)
            .assign(to: &$pokemonModels)
        
        /// Filtering Pokemon based on search bar criteria
        searchTextFieldModel
            .$textEntry
            .receive(on: scheduler)
            .map({ [weak self] in
                guard let self = self,
                      !self.isSearchBarDebounceActive
                else { return "" }

                return $0.removeTrailingSpaces()
            })
            .assign(to: &dataStores.pokemonDataStore.$activeSearchQuery)
        
        /// Search Results Counter
        dataStores
            .pokemonDataStore
            .$searchResultCount
            .assign(to: &$searchResultsCount)
        
        /// Detect if the user is currently searching
        searchTextFieldModel
            .$textEntry
            .combineLatest(searchTextFieldModel.$focused)
            .sink(receiveValue: { [weak self] (_, bool) in
                guard let self = self
                else { return }
                
                self.isSearching = self.userHasSearchQuery && !self.isSearchBarDebounceActive && bool
            })
            .store(in: &cancellables)
    
        /// Filter by pokemon type
        $currentlySelectedPokemonTypeSelectionChip
            .receive(on: scheduler)
            .sink(receiveValue: { [weak self] in
                guard let self = self
                else { return }
                
                self.dataStores
                    .pokemonDataStore
                    .activePokemonTypeFilter = $0?.pokemonType
            })
            .store(in: &cancellables)
    }
    
    func moveSelectedChipToFront() {
        guard let selectedChip = currentlySelectedPokemonTypeSelectionChip,
              let selectionIndex = self.pokemonTypeSelectionChips.firstIndex(of: selectedChip)
        else { return }
        
        pokemonTypeSelectionChips.swapAt(0, selectionIndex)
    }
    
    // MARK: - Refreshing
    func refresh() {
        dataStores
            .pokemonDataStore
            .refresh()
    }
}

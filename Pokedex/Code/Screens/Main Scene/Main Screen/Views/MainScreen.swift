//
//  MainScreen.swift
//  Pokedex
//
//  Created by Justin Cook on 2/13/23.
//

import SwiftUI
import Sheathed_TextField_SwiftUI
import Shimmer

struct MainScreen: View {
    // MARK: - Observed
    @StateObject var model: MainScreenViewModel
    
    // MARK: - Padding
    private let leadingSectionPadding: CGFloat = 30,
                topPadding: CGFloat = 60,
                pokemonListViewItemSpacing: CGFloat = 20,
                pokemonListViewHorizontalPadding: CGFloat = 20,
                pokemonListViewTopPadding: CGFloat = 50,
                searchBarTopPadding: CGFloat = 20,
                searchResultsCountTopPadding: CGFloat = 10
    
    var body: some View {
        mainSection
            .animation(.spring(),
                       value: model.isSearching)
    }
}

// MARK: - Sections
extension MainScreen {
    var mainSection: some View {
        ZStack {
            backgroundArt
            
            ScrollView(.vertical) {
                VStack(spacing: 0) {
                    titleView
                    
                    searchBar
                        .padding(.top,
                        searchBarTopPadding)
                    
                    pokemonTypeSelectionChips
                    
                    searchResultsCount
                    
                    
                    pokemonListView
                        .padding(.top,
                        pokemonListViewTopPadding)
                    
                    Spacer()
                }
                .padding(.top,
                         topPadding)
            }
            .refreshable {
                model.refresh()
            }
        }
    }
}

// MARK: - Subviews
extension MainScreen {
    var pokemonTypeSelectionChips: some View {
        GeometryReader { geom in
            ScrollView(.horizontal,
                       showsIndicators: false) {

                HStack {
                   Spacer(minLength: 20)

                    LazyHStack(alignment: .center,
                               spacing: 10) {
                        ForEach(model.pokemonTypeSelectionChips,
                                id: \.id) {
                            PokemonTypeSelectionChipView(model: $0,
                                                         parentModel: self.model)
                        }
                                .transition(.scale.animation(.spring()))
                    }

                    Spacer(minLength: 20)
                }
            }
                       .frame(width: geom.size.width,
                              height: 40)
        }
        .animation(.spring(),
                   value: model.currentlySelectedPokemonTypeSelectionChip)
        .frame(height: 30)
        .padding(.top, 20)
    }

    var searchBar: some View {
        SheathedTextField(model: model.searchTextFieldModel)
    }
    
    var searchResultsCount: some View {
        Group {
            if model.isSearching {
                HStack {
                    Spacer()
                    Text(model.searchResultsCountText)
                        .withFont(model.searchResultsFont)
                        .foregroundColor(model.searchResultsFontColor)
                        .multilineTextAlignment(.center)
                        .lineLimit(1)
                }
                .padding(.trailing,
                         leadingSectionPadding)
                .padding(.top,
                         searchResultsCountTopPadding)
            }
        }
    }
    
    var titleView: some View {
        HStack {
            Text(model.title)
                .withFont(model.titleFont)
                .fontWeight(model.titleFontWeight)
                .foregroundColor(model.titleForegroundColor)
                .multilineTextAlignment(.center)
                .lineLimit(1)
         
            Spacer()
        }
        .padding(.leading,
                 leadingSectionPadding)
    }
    
    var pokemonListView: some View {
                LazyVGrid(columns: [GridItem(),GridItem()],
                          spacing: pokemonListViewItemSpacing) {
                    Group {
                        if model.isPokedexLoading {
                            ForEach(model.lazyLoadingPlaceholderViewRange, id: \.self) { pokemon in
                                
                                PokemonGridView(model: .init(router: model.router, pokemon: .getMockData()))
                                    .redacted(reason: .placeholder)
                                    .shimmering(active: true,
                                                bounce: true)
                            }
                            .transition(.offset(x: 2000))
                        }
                        else {
                            ForEach(model.pokemonModels,
                                    id: \.element.id) { pokemon in
                                
                                PokemonGridView(model: .init(router: model.router, pokemon: pokemon))
                            }
                                    .transition(.offset(x: -2000))
                        }
                    }
                }
        .padding(.horizontal,
                 pokemonListViewHorizontalPadding)
        .animation(.spring(),
                   value: model.pokemonModels.count)
    }
    
    var backgroundArt: some View {
        HStack {
            Spacer()
            VStack {
                model.backgroundArt
                    .fittedResizableTemplateImageModifier()
                    .frame(width: 300, height: 300)
                    .foregroundColor(model.backgroundArtColor)
                    .offset(x: 100, y: -125)
                
                Spacer()
            }
        }
    }
}

struct MainScreen_Previews: PreviewProvider {
    static func getModel() -> MainScreenViewModel {
        let coordinator: MainCoordinator = RootCoordinatorDispatcher(delegate: .shared).getRootCoordinatorFor(root: .mainCoordinator) as! MainCoordinator
        
        let model = coordinator
            .router
            .mainScreenViewModel!
        
        return model
    }
    
    static var previews: some View {
        MainScreen(model:
              getModel())
    }
}

//
//  MainRouter.swift
//  Pokedex
//
//  Created by Justin Cook on 2/13/23.
//

import SwiftUI
import OrderedCollections

class MainRouter: Routable {
    typealias Route = MainRoutes
    typealias Body = AnyView
    
    // MARK: -  View Models
    @Published var mainScreenViewModel: MainScreenViewModel!
    @Published var pokemonDetailScreenViewModel: PokemonDetailScreenViewModel!
    
    // MARK: - Published
    /// Used by the detail view to determine which pokemon to display in full detail
    @Published var currentlySelectedPokemonID: Int? = nil
    
    // MARK: - Observed
    @ObservedObject var coordinator: MainCoordinator
    
    init(coordinator: MainCoordinator) {
        self.coordinator = coordinator
        
        initViewModels()
    }
    
    func initViewModels() {
        self.mainScreenViewModel = .init(coordinator: self.coordinator)
        self.pokemonDetailScreenViewModel = .init(coordinator: self.coordinator,
                                                  router: self)
    }
    
    func getPath(to route: MainRoutes) -> OrderedCollections.OrderedSet<MainRoutes> {
        switch route {
        case .main:
            return [.main]
        case .detailView:
            return [.main, .detailView]
        }
    }
    
    func getStringLiteral(for route: Route) -> String {
        return route.rawValue
    }
    
    func view(for route: MainRoutes) -> AnyView {
        var view: any View = EmptyView()
        var statusBarHidden: Bool = false
        
        switch route {
        case .main:
            view = MainScreen(model: self.mainScreenViewModel)
            
            statusBarHidden = false
        case .detailView:
            view = PokemonDetailScreen(model: self.pokemonDetailScreenViewModel)
            
            statusBarHidden = true
        }
 
        self.coordinator.statusBarHidden = statusBarHidden
        return AnyView(view
            .routerStatusBarVisibilityModifier(visible: statusBarHidden,
                                               coordinator: self.coordinator)
        )
    }
}


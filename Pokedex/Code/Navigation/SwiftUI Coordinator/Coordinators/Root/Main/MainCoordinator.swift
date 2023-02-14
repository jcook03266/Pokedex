//
//  MainCoordinator.swift
//  Pokedex
//
//  Created by Justin Cook on 2/13/23.
//

import SwiftUI
import Combine
import UIKit

class MainCoordinator: RootCoordinator {
    typealias Router = MainRouter
    typealias Body = AnyView
    
    // MARK: - Properties
    unowned var parent: any Coordinator {
        return self
    }
    var children: [any Coordinator] = []
    var deferredDismissalActionStore: [MainRoutes : (() -> Void)?] = [:]
    var statusBarHidden: Bool = true // Important: Do not publish changes from this variable, it disrupts the presentation of sheet modifiers
    
    // MARK: - Published
    @Published var router: MainRouter!
    @Published var navigationPath: [MainRoutes] = []
    @Published var sheetItem: MainRoutes?
    @Published var fullCoverItem: MainRoutes?
    @Published var rootView: AnyView!
    @Published var rootRoute: MainRoutes!
    
    // MARK: - Observed
    @ObservedObject var rootCoordinatorDelegate: RootCoordinatorDelegate
    
    // MARK: - Subscriptions
    private var cancellables: Set<AnyCancellable> = []
    private let scheduler: DispatchQueue = DispatchQueue.main
    
    init(rootCoordinatorDelegate: RootCoordinatorDelegate = .shared) {
        self.rootCoordinatorDelegate = rootCoordinatorDelegate
        self.router = MainRouter(coordinator: self)
        self.rootRoute = rootCoordinatorDelegate.mainRootRoute
        self.rootView = router.view(for: rootRoute)
        
        UINavigationBar.changeAppearance(clear: true)
    }
    
    // MARK: - Root Coordinated View Builders
    func coordinatorView() -> AnyView {
        AnyView(MainCoordinatorView(coordinator: self))
    }
    
    func coordinatedView() -> any CoordinatedView {
        return MainCoordinatorView(coordinator: self)
    }
}


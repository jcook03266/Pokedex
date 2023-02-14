//
//  RootCoordinator.swift
//  Pokedex
//
//  Created by Justin Cook on 2/13/23.
//

import SwiftUI

class RootCoordinatorDelegate: ObservableObject {
    // MARK: - Published
    @Published var activeRoot: RootCoordinatorDispatcher.RootCoordinators = .mainCoordinator
    
    // MARK: - Root Coordinator management
    var dispatcher: RootCoordinatorDispatcher!
    var activeRootCoordinator: (any RootCoordinator)!
    
    // MARK: - Singleton Instance to prevent reinstantiation at runtime
    static let shared: RootCoordinatorDelegate = .init()
    
    // MARK: - Reference values to be used whenever needed
    static var rootSwitchAnimationBlendDuration: CGFloat = 0.75
    
    // MARK: - Root Routes for Root Coordinators
    var mainRootRoute: MainRoutes = .main
    
    private init() {
        self.dispatcher = .init(delegate: self)
        activeRootCoordinator = dispatcher
            .getRootCoordinatorFor(root: .mainCoordinator)
    }
    
    /// Transitions the user to the specified scene, with that scene handling any transition animations
    func switchActiveRoot(to root: RootCoordinatorDispatcher.RootCoordinators) {
        guard root != self.activeRoot else { return }

        activeRoot = root
        activeRootCoordinator = dispatcher.getRootCoordinatorFor(root: root)
    }
    
    // MARK: - Convenience functions
    func switchToMainScene() {
        switchActiveRoot(to: .mainCoordinator)
    }
}

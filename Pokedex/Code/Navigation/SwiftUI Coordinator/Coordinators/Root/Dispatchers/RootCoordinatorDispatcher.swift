//
//  RootCoordinatorDispatcher.swift
//  Pokedex
//
//  Created by Justin Cook on 2/13/23.
//

import Foundation

/// Dispatches root coordinators
class RootCoordinatorDispatcher {
    var delegate: RootCoordinatorDelegate
    
    var mainCoordinator: MainCoordinator!
    
    init(delegate: RootCoordinatorDelegate) {
        self.delegate = delegate
        
        initCoordinators()
    }
    
    func initCoordinators() {
        mainCoordinator = .init(rootCoordinatorDelegate: delegate)
    }
    
    func getRootCoordinatorFor(root: RootCoordinators) -> any RootCoordinator {
        switch root {
        case .mainCoordinator:
            return self.mainCoordinator
        }
    }
    
    /// Keeps track of all root coordinators
    enum RootCoordinators: Hashable, CaseIterable {
        case mainCoordinator
    }
}

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
    @StateObject var appService: AppService = .shared
    
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
    }
}

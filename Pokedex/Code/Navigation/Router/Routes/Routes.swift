//
//  Routes.swift
//  Pokedex
//
//  Created by Justin Cook on 2/13/23.
//

import Foundation

// MARK: - Router Routes
/// Enums of all possible router routes (views) depending on the router
/// Each router is responsible for a specific set of views that it expects to present somewhere in its view hierarchy, this centralizes the app's navigation pathways to one source of truth
/// Note: Any new views must be added under their respective router
enum MainRoutes: String, CaseIterable, Hashable, RoutesProtocol {
    case main
    case detailView
}

// MARK: - Deeplink Navigation Traversal
/// An enum that specifies the method of presentation for a target view, each view can be presented in a number of ways
/// Note: Please be advised that SwiftUI does not support multiple sheets being presented at once, if this is the case each sheet must be popped and a new one has to be presented in its place
enum PreferredViewPresentationMethod: String, CaseIterable, Hashable {
    case navigationStack = "ns"
    case bottomSheet = "bs"
    case fullCover = "fc"
    
    static func getPresentationType(from route: String) -> Self {
        let components = route.components(separatedBy: " ")
        
        for method in PreferredViewPresentationMethod.allCases {
            if components.contains(method.rawValue) {
                return method
            }
        }
        
        return navigationStack
    }
}

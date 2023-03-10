//
//  Router.swift
//  Pokedex
//
//  Created by Justin Cook on 2/13/23.
//

import SwiftUI
import OrderedCollections

/// Responsibilities: Knows how to create views, create views, presents views, and dismisses views
public protocol Routable: ObservableObject {
    typealias RouteType = Hashable & CaseIterable
    associatedtype Route: RouteType
    associatedtype Body: View
    
    @ViewBuilder func view(for route: Route) -> Self.Body
    
    /// Optional func for abstracting the intialization of any retained view models by the router
    func initViewModels() -> Void
    
    func getPath(to route: Route) -> OrderedSet<Route>
    
    func getStringLiteral(for route: Route) -> String
}

extension Routable {
    func initViewModels() {}
}

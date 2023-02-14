//
//  GenericViewModelProtocol.swift
//  Pokedex
//
//  Created by Justin Cook on 2/13/23.
//

import SwiftUI

/// Basis for observable view models, allows a view to respond to changes within the target object's values
protocol GenericViewModel: ObservableObject, Identifiable {
    var id: UUID { get }
}

// MARK: - Implementations
extension GenericViewModel {
    var id: UUID {
        return UUID()
    }
}

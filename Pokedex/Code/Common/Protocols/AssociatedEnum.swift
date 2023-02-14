//
//  AssociatedEnum.swift
//  Pokedex
//
//  Created by Justin Cook on 2/13/23.
//

import Foundation

/** Protocol for retrieving generic associated values from an enum*/
protocol AssociatedEnum: CaseIterable {
    associatedtype associatedValue: Any
    
    func getAssociatedValue() -> associatedValue
}

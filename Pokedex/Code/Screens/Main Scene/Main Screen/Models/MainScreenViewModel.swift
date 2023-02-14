//
//  MainScreenViewModel.swift
//  Pokedex
//
//  Created by Justin Cook on 2/13/23.
//

import SwiftUI

class MainScreenViewModel: GenericViewModel {
    typealias coordinator = MainCoordinator
    
    // MARK: - Observed
    @ObservedObject var coordinator: coordinator
    
    // MARK: - Styling
    // Colors
//    let backgroundColor: Color = Color.clear,
//        foregroundContainerColor: Color = Colors.neutral_100.0,
//        titleForegroundColor: Color = Colors.permanent_white.0,
//        titleIconForegroundColor: Color = Colors.permanent_white.0
    
    // Fonts
//    let titleFont: FontRepository = .heading_2,
//        titleFontWeight: Font.Weight = .semibold
    
    // MARK: - Assets
    /// Images
   // let titleIcon: Image = Icons.getIconImage(named: .gear)
    
    // MARK: - Localized Text
//    let title: String = LocalizedStrings.getLocalizedString(for: .SETTINGS_SCREEN_TITLE)
    
    init(coordinator: coordinator) {
        self.coordinator = coordinator
    }
}

//
//  LocalizedStrings.swift
//  Pokedex
//
//  Created by Justin Cook on 2/14/23.
//

import Foundation
import SwiftUI

/// Note: If a new string is added to the localization file(s) please update these enums accordingly
enum LocalizedStrings: String, CaseIterable {
    case APP_NAME
}

extension LocalizedStrings {
    /// String keys for SwiftUI and compiler time localization
    static func getLocalizedStringKey(for key: LocalizedStrings) -> LocalizedStringKey {
        
        return LocalizedStringKey(key.rawValue)
    }
    
    /// Strings for UIKit and manual localization
    static func getLocalizedString(for string: LocalizedStrings) -> String {
        return string.rawValue.localized
    }
}


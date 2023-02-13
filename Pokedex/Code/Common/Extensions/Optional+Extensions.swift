//
//  Optional+Extensions.swift
//

import Foundation

/// Convenient extension of the optional type that promotes a cleaner method of unwrapping
extension Optional {
    func unwrap(defaultValue: Wrapped) -> Wrapped {
        guard let self = self
        else {
            ErrorCodeDispatcher
                .SwiftErrors
                .printErrorCode(for: .nilValueUnwrapped)
            
            return defaultValue
        }
        
        return self
    }
}

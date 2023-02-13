//
//  Array+Tuple+Extensions.swift
//

import Foundation

/// Convert tuples or any sequence of elements into an array through the Mirror API
extension Array {
    /// Optional Initializer
    init?<Subject>(optionallyMirrorChildValuesOf subject: Subject) {
        guard let array = Mirror(reflecting: subject)
            .children
            .map(\.value)
                as? Self
        else { return nil }
        
        self = array
    }
    
    /// Non-optional, if mirror fails then an empty array is initialized
    init<Subject>(mirrorChildValuesOf subject: Subject) {
        let array = Mirror(reflecting: subject)
            .children
            .map(\.value)
                as? Self
        
        self = array ?? Self()
    }
}

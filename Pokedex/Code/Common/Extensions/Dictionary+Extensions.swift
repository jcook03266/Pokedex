//
//  Dictionary+Extensions.swift
//

import Foundation

/// Reduces the need for a ternary statement by specifying the default value when the key passed to the dictionary results in nil
extension Dictionary where Value == Any {
    func value<T>(forKey key: Key, defaultValue: @autoclosure () -> T) -> T {
        guard let value = self[key] as? T else {
            return defaultValue()
        }

        return value
    }
}

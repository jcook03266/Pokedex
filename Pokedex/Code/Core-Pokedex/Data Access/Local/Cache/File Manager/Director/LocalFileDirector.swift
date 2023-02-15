//
//  LocalFileDirector.swift
//  Pokedex
//
//  Created by Justin Cook on 2/14/23.
//

import Foundation

/// A class that encapsulates all specialized file managers and acts as a centralized entry point into all of the possible managers
struct LocalFileDirector {
    static let imageFileManager: ImageFileManager = .shared
}

//
//  PokedexApp.swift
//  Pokedex
//
//  Created by Justin Cook on 2/13/23.
//

import SwiftUI

@main
struct PokedexApp: App {
    var body: some Scene {
        WindowGroup {
            Group {
                
            }
            .onAppear {
                onLoadTasks()
            }
        }
    }
    
    func onLoadTasks() {
        Apollo().loadData()
    }
}

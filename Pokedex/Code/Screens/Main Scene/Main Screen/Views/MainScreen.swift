//
//  MainScreen.swift
//  Pokedex
//
//  Created by Justin Cook on 2/13/23.
//

import SwiftUI

struct MainScreen: View {
    // MARK: - Observed
    @StateObject var model: MainScreenViewModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct MainScreen_Previews: PreviewProvider {
    static func getModel() -> MainScreenViewModel {
        let coordinator: MainCoordinator = RootCoordinatorDispatcher(delegate: .shared).getRootCoordinatorFor(root: .mainCoordinator) as! MainCoordinator
        
        let model = coordinator
            .router
            .mainScreenViewModel!
        
        return model
    }
    
    static var previews: some View {
        MainScreen(model:
              getModel())
    }
}

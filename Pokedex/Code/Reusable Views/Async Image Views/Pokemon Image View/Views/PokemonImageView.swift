//
//  PokemonImageView.swift
//  Pokedex
//
//  Created by Justin Cook on 2/14/23.
//

import SwiftUI

struct PokemonImageView: View {
    // MARK: - Observed Objects
    @StateObject var model: PokemonImageViewModel
    
    // MARK: - Dimensions
    var size: CGSize = .init(width: 30, height: 30)

    // MARK: - Subviews
    var imageView: some View {
        ZStack {
            if let image = model.image {
                Image(uiImage: image)
                    .resizable()
                    .renderingMode(.original)
                    .aspectRatio(contentMode: .fit)
                    .transition(.scale)
            }
        }
        .frame(width: size.width,
               height: size.height)
    }

    var body: some View {
        imageView
        .animation(
            .spring(),
            value: model.isLoading)
        .frame(width: 100,
               height: 100)
    }
}

struct CoinImageView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonImageView(model: .init(pokemonModel: MinimalPokemonModel.getMockData()))
            .previewLayout(.sizeThatFits)
    }
}

//
//  PokemonGridView.swift
//  Pokedex
//
//  Created by Justin Cook on 2/14/23.
//

import SwiftUI

struct PokemonGridView: View {
    // MARK: - Observed
    @StateObject var model: PokemonGridViewModel
    
    // MARK: - Dimensions
    private let height: CGFloat = 140,
                cornerRadius: CGFloat = 20,
                shadowRadius: CGFloat = 3,
                shadowOffset: CGSize = .init(width: 0,
                                             height: 3),
                pokemonTypePillCornerRadius: CGFloat = 40,
                pokemonTypePillHeight: CGFloat = 25,
                backgroundArtImageSize: CGSize = .init(width: 120,
                                                       height: 120),
                metaDataSectionMaxWidth: CGFloat = 120
    
    // MARK: - Padding
    private let bottomPokemonImagePadding: CGFloat = 10,
                trailingPokemonImagePadding: CGFloat = -2.5,
                metadataSectionTopPadding: CGFloat = 25,
                leadingPadding: CGFloat = 10,
                pokemonTypePillPadding: CGFloat = 10,
                trailingPokemonOrderPadding: CGFloat = 20,
                topPokemonOrderPadding: CGFloat = 10
    
    var body: some View {
        Button {
            model.action()
        } label: {
            mainSection
        }
        .buttonStyle(.genericSpringyShrink)
    }
}

// MARK: - Sections
extension PokemonGridView {
    var mainSection: some View {
        GeometryReader { geom in
            ZStack {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(model.backgroundColor)
                    .overlay {
                        innerContentSection
                    }
                    .clipped()
                
                pokemonOrderTextView
                
            }
            .frame(width: geom.size.width,
                   height: height)
            
        }
        .frame(height: height)
        .shadow(color: model.shadowColor,
                radius: shadowRadius,
                x: shadowOffset.width,
                y: shadowOffset.height)
    }
    
    var innerContentSection: some View {
        ZStack {
            image
            
            metadataSection
            
            pokemonImage
        }
    }
    
    var metadataSection: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    pokemonNameView
                    Spacer()
                }
                pokemonTypesList
                
                Spacer()
            }
            .padding(.top,
                     metadataSectionTopPadding)
            .frame(maxWidth: metaDataSectionMaxWidth)
            
            Spacer()
        }
        .padding(.leading,
                 leadingPadding)
    }
}

// MARK: - Subviews
extension PokemonGridView {
    var image: some View {
        ZStack(alignment: .bottomTrailing) {
            HStack {
                Spacer()
                model.backgroundArt
                    .fittedResizableTemplateImageModifier()
                    .foregroundColor(model.backgroundArtColor)
                    .frame(width: backgroundArtImageSize.width,
                           height: backgroundArtImageSize.height)
                    .offset(x: 20, y: 30)
            }
        }
    }
    
    var pokemonImage: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                PokemonImageView(model: .init(pokemonModel: model.minimalPokemonModel), size: .init(width: 100, height: 100))
            }
        }
        .padding(.trailing,
                 trailingPokemonImagePadding)
        .padding(.bottom,
                 bottomPokemonImagePadding)
    }
    
    var pokemonOrderTextView: some View {
        VStack {
            HStack {
                Spacer()
                Text(model.pokemonIDNumber)
                    .withFont(model.pokemonOrderFont)
                    .multilineTextAlignment(.center)
                    .lineLimit(1)
                    .minimumScaleFactor(0.9)
                    .foregroundColor(model.orderTextColor)
            }
            Spacer()
        }
        .padding(.top,
                 topPokemonOrderPadding)
        .padding(.trailing,
                 trailingPokemonOrderPadding)
    }
    
    var pokemonNameView: some View {
        Text(model.pokemonName)
            .withFont(model.nameFont)
            .multilineTextAlignment(.center)
            .lineLimit(1)
            .minimumScaleFactor(0.9)
            .foregroundColor(model.nameTextColor)
    }
    
    var pokemonTypesList: some View {
        VStack(alignment: .leading) {
            ForEach(model.pokemonTypes, id: \.self) { pokemonType in
                
                ZStack {
                    RoundedRectangle(cornerRadius: pokemonTypePillCornerRadius)
                        .fill(model.pokemonTypeChipletBackgroundColor)
                    
                    Text(pokemonType)
                        .withFont(model.pokemonTypeFont)
                        .multilineTextAlignment(.center)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .foregroundColor(model.typeTextColor)
                        .padding(.horizontal,
                                 pokemonTypePillPadding)
                }
                .scaledToFit()
                .frame(height: pokemonTypePillHeight)
            }
        }
    }
}

struct PokemonGridView_Previews: PreviewProvider {
    static func getModel() -> PokemonGridViewModel {
        let coordinator: MainCoordinator = RootCoordinatorDispatcher(delegate: .shared).getRootCoordinatorFor(root: .mainCoordinator) as! MainCoordinator
        
        let pokemon = MinimalPokemonModel.getMockData()
        
        let model = PokemonGridViewModel(router: coordinator.router,
                                         pokemon: pokemon)
        
        return model
    }
    
    
    static var previews: some View {
        PokemonGridView(model: getModel())
            .padding(.all, 10)
    }
}

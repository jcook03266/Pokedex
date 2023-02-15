//
//  PokemonTypeSelectionChipView.swift
//  Pokedex
//
//  Created by Justin Cook on 2/15/23.
//

import SwiftUI

struct PokemonTypeSelectionChipView: View {
    // MARK: - Observed
    @StateObject var model: PokemonTypeSelectionChipViewModel
    @ObservedObject var parentModel: MainScreenViewModel
       
       // MARK: - Dimensions
    private let size: CGSize = .init(width: 70, height: 30),
                cornerRadius: CGFloat = 20
    
    // MARK: - Padding
    private let horizontalPadding: CGFloat = 5,
                verticalPadding: CGFloat = 5
       
       // MARK: - Styling
       // Shadow
       private var shadowOffset: CGSize {
           return model.isSelected ? .init(width: 0, height: 3) : .zero
       }
       private var shadowColor: Color {
           return model.isSelected ? Colors.shadow_1.0 : Color.clear
       }
       private var shadowRadius: CGFloat {
           return model.isSelected ? 2 : 0
       }
    
    // MARK: - Subviews
    var backgroundView: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(model.backgroundColor)
            .shadow(color: model.shadowColor,
                    radius: shadowRadius,
                    x: shadowOffset.width,
                    y: shadowOffset.height)
    }
    
    var textView: some View {
        Text(model.label)
            .withFont(model.font)
            .fontWeight(model.fontWeight)
            .foregroundColor(model.foregroundColor)
            .minimumScaleFactor(0.1)
            .multilineTextAlignment(.center)
            .lineLimit(1)
            .padding([.top, .bottom], verticalPadding)
            .padding([.leading, .trailing], horizontalPadding)
    }
    
    // MARK: - Sections
    var chipBody: some View {
        Button {
            model.action()
            
            guard parentModel.currentlySelectedPokemonTypeSelectionChip != model
            else {
                parentModel.currentlySelectedPokemonTypeSelectionChip = nil
                return
            }
            
            parentModel.currentlySelectedPokemonTypeSelectionChip = model
            parentModel.moveSelectedChipToFront()
        } label: {
            ZStack(alignment: .center) {
                backgroundView
                textView
            }
        }
        .frame(width: size.width,
               height: size.height)
    }
    
    var body: some View {
        chipBody
            .onChange(of: parentModel.currentlySelectedPokemonTypeSelectionChip) { newChip in
                
                /// Updates all rows depending on the newest selected row
                if newChip != model {
                    model.isSelected = false
                }
                else {
                    model.isSelected = true
                }
            }
    }
}

struct PokemonTypeSelectionChipView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonTypeSelectionChipView(model: .init(isSelected: true,
                                                  pokemonType: .bug,
                                                  action: {},
                                                  label: PokemonType.bug.rawValue),
                                     parentModel: .init(coordinator: .init()))
            .previewLayout(.sizeThatFits)
            .padding(20)
    }
}

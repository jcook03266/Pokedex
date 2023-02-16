//
//  BaseStatProgressView.swift
//  Pokedex
//
//  Created by Justin Cook on 2/15/23.
//

import SwiftUI

struct BaseStatProgressView: View {
    // MARK: - Properties
    var progress: Double
    let maxProgressAmount: Double
    
    private var totalProgressRatio: CGFloat {
        return progress/maxProgressAmount
    }
    
    // MARK: - Dimensions
    var height: CGFloat = 10,
        cornerRadius: CGFloat = 40
    
    // MARK: - Styling
    var barColor: Color {
        if totalProgressRatio <= 0.3 {
            return Colors.getColor(named: .pokemon_red)
        }
        else if totalProgressRatio <= 0.6 {
            return Colors.getColor(named: .pokemon_brown)
        }
        else {
            return Colors.getColor(named: .pokemon_green)
        }
    }
    
    var body: some View {
        ZStack {
            background
            interiorProgressView
        }
        .frame(height: height)
    }
    
    var interiorProgressView: some View {
        GeometryReader { geom in
            
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(barColor)
                .frame(width: geom.size.width * totalProgressRatio)
        }
    }
    
    var background: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(Colors.neutral_200.0)
    }
}

struct BaseStatProgressView_Previews: PreviewProvider {
    static var previews: some View {
        BaseStatProgressView(progress: 50,
                             maxProgressAmount: 100)
        .padding(.horizontal, 10)
    }
}

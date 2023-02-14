//
//  ShapeModifiers.swift
//  Pokedex
//
//  Created by Justin Cook on 2/13/23.
//

import SwiftUI

/// Modifies the stroke properties of the given shape using view builder
struct ShapeBorderModifier<Content: Shape>: View {
    let content: Content
    
    var borderColor: Color,
        borderWidth: CGFloat,
        borderEnabled: Bool
    
    init(@ViewBuilder content: () -> Content,
         borderColor: Color = Color.black,
         borderWidth: CGFloat = 2,
         borderEnabled: Bool = true )
    {
        self.content = content()
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.borderEnabled = borderEnabled
    }
    
    var body: some View {
        content
            .stroke(borderEnabled ? borderColor : .clear,
                    style: StrokeStyle(lineWidth: borderEnabled ? borderWidth : 0))
    }
}

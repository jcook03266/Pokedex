//
//  SwiftUIAnimationTransitions.swift
//

import SwiftUI

extension AnyTransition {
    static var slideBackwards: AnyTransition {
        AnyTransition.asymmetric(insertion: .move(edge: .trailing),
                                 removal: .move(edge: .leading))
    }
    static var slideForwards: AnyTransition {
        AnyTransition.slide
    }
}

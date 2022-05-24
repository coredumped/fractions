//
//  Fraction+Operations.swift
//  fractions
//
//  Created by Juan Guerrero on 05/21/22.
//

import Foundation

extension Fraction {
    
    static func / (left: Fraction, right: Fraction) -> Fraction {
        return left * right.inverted()
    }
    
}

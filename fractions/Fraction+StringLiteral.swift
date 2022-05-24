//
//  Fraction+StringLiteral.swift
//  fractions
//
//  Created by Juan Guerrero on 05/21/22.
//

import Foundation

extension Fraction: ExpressibleByUnicodeScalarLiteral, ExpressibleByExtendedGraphemeClusterLiteral, ExpressibleByStringLiteral {
    typealias ExtendedGraphemeClusterLiteralType = String
    typealias StringLiteralType = String
    typealias UnicodeScalarLiteralType = String
    
    init(stringLiteral value: String) {
        self = Fraction.parse(string: value)
    }
    
    private static func parse(string: String) -> Fraction {
        guard let f = ArithmeticExpression.parseFraction(string: string) else {
            return .nan
        }
        return f.fraction
    }
}

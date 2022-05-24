//
//  Fraction.swift
//  fractions
//
//  Created by Juan Guerrero on 05/21/22.
//

import Foundation

struct Fraction: CustomStringConvertible, Equatable {
    var numerator: Int
    var denominator: Int
    
    static let nan = Fraction(0, 0)
    
    var isNan: Bool {
        numerator == Fraction.nan.numerator && denominator == Fraction.nan.denominator
    }
    
    init(_ numerator: Int, _ denominator: Int) {
        self.numerator = abs(numerator) * numerator.signum() * denominator.signum()
        self.denominator = abs(denominator)        
    }
    
    init(whole: Int, numerator: Int, denominator: Int) {
        let sign = whole.signum()
        self.numerator = sign * (abs(whole * denominator) + numerator)
        self.denominator = denominator
    }
        
    func simplified() -> Fraction {
        let g = gcd(numerator, denominator)
        return Fraction(numerator / g, denominator / g)
    }
    
    func inverted() -> Fraction {
        return Fraction(denominator, numerator)
    }
    
    mutating func simplify() {
        self = Fraction(self.numerator, self.denominator).simplified()
    }
    
    var properFractionRepresentation: String {
        let fraction = simplified()
        return "\(fraction.numerator)/\(fraction.denominator)"
    }
    
    var improperFractionRepresentation: String {
        let whole = (self.numerator / self.denominator)
        let numerator = abs(self.numerator % self.denominator)
        guard numerator != 0 else {
            return "\(whole)"
        }
        let fractional = Fraction(abs(numerator), self.denominator).simplified()
        return "\(whole)_" + fractional.description
    }
        
    var description: String {
        guard denominator != 0 else {
            return "nan"
        }
        guard numerator != denominator else {
            return "1"
        }
        if abs(numerator) < abs(denominator) {
            return properFractionRepresentation
        } else {
            return improperFractionRepresentation
        }
    }
    
    
    static func == (lhs: Fraction, rhs: Fraction) -> Bool {
        guard !lhs.isNan && !rhs.isNan else {
            return false
        }
        let lhs1 = lhs.simplified()
        let rhs1 = rhs.simplified()
        return lhs1.numerator == rhs1.numerator && lhs1.denominator == rhs1.denominator
    }
}

extension Fraction: AdditiveArithmetic {
    static var zero: Fraction {
        return Fraction(0, 1)
    }
    
    static func + (lhs: Fraction, rhs: Fraction) -> Fraction {
        guard !lhs.isNan && !rhs.isNan else {
            return Fraction.nan
        }
        let lcm = lcm(lhs.denominator, rhs.denominator)
        return Fraction(lhs.numerator * lcm / lhs.denominator + rhs.numerator * lcm / rhs.denominator, lcm).simplified()
    }
    
    static func - (lhs: Fraction, rhs: Fraction) -> Fraction {
        return lhs + Fraction(-rhs.numerator, rhs.denominator)
    }
}

extension Fraction: Comparable {
    static func < (lhs: Fraction, rhs: Fraction) -> Bool {
        if lhs.isNan || rhs.isNan {
            return false
        }
        return Double(lhs.numerator) / Double(lhs.denominator) < Double(rhs.numerator) / Double(rhs.denominator)
    }
}

extension Fraction: ExpressibleByIntegerLiteral {
    init(integerLiteral value: Int) {
        self.numerator = value
        self.denominator = 1
    }
}

extension Fraction: Numeric, SignedNumeric {
    init?<T>(exactly source: T) where T : BinaryInteger {
        self.numerator = Int(source)
        self.denominator = 1
    }
    
    var magnitude: Fraction {
        Fraction(abs(numerator), abs(denominator))
    }
    
    static func * (lhs: Fraction, rhs: Fraction) -> Fraction {
        guard !lhs.isNan && !rhs.isNan else {
            return Fraction.nan
        }
        return Fraction(lhs.numerator * rhs.numerator,
                        lhs.denominator * rhs.denominator).simplified()
    }
    
    static func *= (lhs: inout Fraction, rhs: Fraction) {
        lhs = lhs * rhs
    }
}

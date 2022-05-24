//
//  AuxiliaryFunctions.swift
//  fractions
//
//  Created by Juan Guerrero on 05/21/22.
//

import Foundation

func gcd(_ a0: Int, _ b0: Int) -> Int {
    var a = a0
    var b = b0
    var r = 0    
    if abs(b0) > abs(a0) {
        swap(&a, &b)
    }
    var theGCD = b
    repeat {
       r = a % b
        if r != 0 {
            theGCD = r
            a = b
            b = r
        }
    } while r != 0
    return abs(theGCD)
}

func lcm(_ a: Int, _ b: Int) -> Int {
    return abs(a * b) / gcd(a, b)
}

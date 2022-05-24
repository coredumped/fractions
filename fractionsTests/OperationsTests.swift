//
//  OperationsTests.swift
//  fractionsTests
//
//  Created by Juan Guerrero on 05/23/22.
//

import XCTest

class OperationsTests: XCTestCase {

    func testMultiplication() {
        let a = Fraction(91, 78)
        let b = Fraction(126, 89)
        let c = a * b
        XCTAssertEqual(c, Fraction(147, 89))
        XCTAssertEqual(c.description, "1_58/89")
    }

    func testDivision() {
        let a = Fraction(91, 78)
        let b = Fraction(126, 89)
        let c = a / b
        XCTAssertEqual(c, Fraction(89, 108))
        XCTAssertEqual(c.description, "89/108")
    }     
    
    func testSum() {
        var a = Fraction(1, 2)
        var b = Fraction(1, 2)
        var c = a + b
        XCTAssertEqual(c.description, "1")
        
        a = Fraction(2, 3)
        b = Fraction(3, 5)
        c = a + b
        XCTAssertEqual(c.description, "1_4/15")
    }
    
    func testSubstraction() {
        var a = Fraction(62, 23)
        var b = Fraction(1, 10)
        var c = a - b
        XCTAssertEqual(c.description, "2_137/230")
        
        a = Fraction(6, 246)
        b = Fraction(50, 41)
        c = a - b
        XCTAssertEqual(c.description, "-1_8/41")
    }
}

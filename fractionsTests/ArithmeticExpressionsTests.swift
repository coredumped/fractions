//
//  ArithmeticExpressionsTests.swift
//  fractionsTests
//
//  Created by Juan Guerrero on 05/24/22.
//

import XCTest

class ArithmeticExpressionsTests: XCTestCase {

    func testParseUnsignedIntegerSucceeds() {
        let n = ArithmeticExpression.parseUnsignedInteger(string: "123", index: "123".startIndex)
        XCTAssertEqual(n.integer, 123)
        
        let z = ArithmeticExpression.parseUnsignedInteger(string: "0", index: "0".startIndex)
        XCTAssertEqual(z.integer, 0)
    }
    
    func testParseUnsignedIntegerEatsZeroesToTheLeft() {
        let n = ArithmeticExpression.parseUnsignedInteger(string: "000123", index: "000123".startIndex)
        XCTAssertEqual(n.integer, 123)
        
        let m = ArithmeticExpression.parseUnsignedInteger(string: "000", index: "000".startIndex)
        XCTAssertEqual(m.integer, 0)
        
        let z = ArithmeticExpression.parseUnsignedInteger(string: "1000", index: "1000".startIndex)
        XCTAssertEqual(z.integer, 1000)
    }

    func testMixedFraction() {
        let f = "13_1/2"
        let a = ArithmeticExpression.parseFraction(string: f, index: f.startIndex)
    
        XCTAssertEqual(a?.fraction.numerator, 27)
        XCTAssertEqual(a?.fraction.denominator, 2)
    }
    
    func testMixedExplicitPositiveFraction() {
        let f = "+13_1/2"
        let a = ArithmeticExpression.parseFraction(string: f, index: f.startIndex)
    
        XCTAssertEqual(a?.fraction.numerator, 27)
        XCTAssertEqual(a?.fraction.denominator, 2)
    }

    
    func testNegativeMixedFraction() {
        let f = "-13_1/2"
        let a = ArithmeticExpression.parseFraction(string: f, index: f.startIndex)
    
        XCTAssertEqual(a?.fraction.numerator, -27)
        XCTAssertEqual(a?.fraction.denominator, 2)
        
        XCTAssertEqual(a?.fraction.description, "-13_1/2")
    }

    func testImproperFraction() {
        let f = "3/2"
        let a = ArithmeticExpression.parseFraction(string: f, index: f.startIndex)
    
        XCTAssertEqual(a?.fraction.numerator, 3)
        XCTAssertEqual(a?.fraction.denominator, 2)
    }
    
    func testImproperNegativeFraction() {
        let f = "-7/6"
        let a = ArithmeticExpression.parseFraction(string: f, index: f.startIndex)
    
        XCTAssertEqual(a?.fraction.numerator, -7)
        XCTAssertEqual(a?.fraction.denominator, 6)
    }

    func testProperFraction() {
        let f = "2/3"
        let a = ArithmeticExpression.parseFraction(string: f, index: f.startIndex)
    
        XCTAssertEqual(a?.fraction.numerator, 2)
        XCTAssertEqual(a?.fraction.denominator, 3)
    }
    
    func testProperNegativeFraction() {
        let f = "-1/6"
        let a = ArithmeticExpression.parseFraction(string: f, index: f.startIndex)
    
        XCTAssertEqual(a?.fraction.numerator, -1)
        XCTAssertEqual(a?.fraction.denominator, 6)
    }
    
    func testIgnoresSpacesNegativeProper() {
        let f = "        -1/6 "
        let a = ArithmeticExpression.parseFraction(string: f, index: f.startIndex)
    
        XCTAssertEqual(a?.fraction.numerator, -1)
        XCTAssertEqual(a?.fraction.denominator, 6)
    }

    // MARK: - Arithmetic Expression parsing
    func testParseSum() {
        let o = ArithmeticExpression.parse(string: "1/2 + 1/2")
        XCTAssertEqual(o?.a, "1/2")
        XCTAssertEqual(o?.operation, .sum)
        XCTAssertEqual(o?.b, "1/2")
    }
    
    func testParseSubstract() {
        let o = ArithmeticExpression.parse(string: "1/2 - 1/2")
        XCTAssertEqual(o?.a, "1/2")
        XCTAssertEqual(o?.operation, .substract)
        XCTAssertEqual(o?.b, "1/2")
    }
    
    func testParseMultiply() {
        let o = ArithmeticExpression.parse(string: "1/2 * 1/2")
        XCTAssertEqual(o?.a, "1/2")
        XCTAssertEqual(o?.operation, .multiply)
        XCTAssertEqual(o?.b, "1/2")
    }

    func testParseDivide() {
        let o = ArithmeticExpression.parse(string: "1/2 / 1/2")
        XCTAssertEqual(o?.a, "1/2")
        XCTAssertEqual(o?.operation, .divide)
        XCTAssertEqual(o?.b, "1/2")
    }

    // MARK: - Unparsable
    func testUnparsableFractions() {
        var a = ArithmeticExpression.parseFraction(string: "/2")
        XCTAssertNil(a)
        
        a = ArithmeticExpression.parseFraction(string: "1/")
        XCTAssertNil(a)
        
        a = ArithmeticExpression.parseFraction(string: "a/2")
        XCTAssertNil(a)
        
        a = ArithmeticExpression.parseFraction(string: "a/-2")
        XCTAssertNil(a)
        
        a = ArithmeticExpression.parseFraction(string: "2-2")
        XCTAssertNil(a)
        
        a = ArithmeticExpression.parseFraction(string: "2_2")
        XCTAssertNil(a)
        
        a = ArithmeticExpression.parseFraction(string: "2_/")
        XCTAssertNil(a)
        
        a = ArithmeticExpression.parseFraction(string: "2_2/")
        XCTAssertNil(a)
        
        a = ArithmeticExpression.parseFraction(string: "2_2/a")
        XCTAssertNil(a)

        a = ArithmeticExpression.parseFraction(string: "2_+2/2")
        XCTAssertNil(a)

        a = ArithmeticExpression.parseFraction(string: "2_2/+2")
        XCTAssertNil(a)
    }
    
    func testUnparsableArithmeticExpression() {
        var expr = ArithmeticExpression.parse(string: "1/ + 1/5")
        XCTAssertNil(expr)
        
        expr = ArithmeticExpression.parse(string: "-1/2 ^ 1/5")
        XCTAssertNil(expr)
        
        expr = ArithmeticExpression.parse(string: "1_4/5 + 4-1/5")
        XCTAssertNil(expr)
        
        expr = ArithmeticExpression.parse(string: "1_4/5 + 1/5 - 8/9")
        XCTAssertNil(expr)
    }
}

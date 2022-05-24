//
//  fractionsTests.swift
//  fractionsTests
//
//  Created by Juan Guerrero on 05/23/22.
//

import XCTest

class fractionsTests: XCTestCase {


    func testProperFractionFormat() {
        let a = Fraction(1, 2)
        XCTAssertEqual(a.description, "1/2")
        let b = Fraction(1, -4)
        XCTAssertEqual(b.description, "-1/4")
        let c = Fraction(-1, 6)
        XCTAssertEqual(c.description, "-1/6")
    }
    
    func testImProperFractionFormat() {
        let a = Fraction(3, 2)
        XCTAssertEqual(a.description, "1_1/2")
        let b = Fraction(8, 4)
        XCTAssertEqual(b.description, "2")
        let c = Fraction(-1053, 325)
        XCTAssertEqual(c.description, "-3_6/25")
    }
    
    func testSimplication() {
        let a = Fraction(35, 42).simplified()
        XCTAssertEqual(a.numerator, 5)
        XCTAssertEqual(a.denominator, 6)
        XCTAssertEqual(a.description, "5/6")
    }
    
    func testIntegerLiteralAssignment() {
        let a: Fraction = -5
        XCTAssertEqual(a.numerator, -5)
        XCTAssertEqual(a.denominator, 1)
        XCTAssertEqual(a.description, "-5")
    }
    
    func testFractionNanRules() {
        let a: Fraction = "-1_2/5"
        XCTAssertNotEqual(a + .nan, .nan)
        XCTAssertNotEqual(a - .nan, .nan)
        XCTAssertNotEqual(a * .nan, .nan)
        XCTAssertNotEqual(a / .nan, .nan)
        
        XCTAssertNotEqual(Fraction.nan, Fraction.nan)
    }
    
    func testStringLiteralAssignment() {
        let a: Fraction = "-5_1/2"
        XCTAssertEqual(a.numerator, -11)
        XCTAssertEqual(a.denominator, 2)

        let b: Fraction = "2/4"
        XCTAssertEqual(b.numerator, 2)
        XCTAssertEqual(b.denominator, 4)

        let c = a + b
        XCTAssertEqual(c, -5)
    }
    
    func testIntLiteralAssignment() {
        let a: Fraction = 10
        XCTAssertEqual(a.numerator, 10)
        XCTAssertEqual(a.denominator, 1)
        XCTAssertEqual(a, 10)
        XCTAssertEqual(a.description, "10")
    }
    
    func testWrongFormattedLiteralReturnsNan() {
        let a: Fraction = " -a/b "
        XCTAssertTrue(a.isNan)
    }
    
    func testMutatingSimplication() {
        var fraction: Fraction = "75/10"
        fraction.simplify()
        XCTAssertEqual(fraction.numerator, 15)
        XCTAssertEqual(fraction.denominator, 2)
        
        XCTAssertEqual(fraction, "7_1/2")
    }
    
    func testCompare() {
        let oneHalf: Fraction = "1/2"
        XCTAssertLessThan(oneHalf, 1)
        
        XCTAssertFalse(oneHalf < .nan)
        XCTAssertFalse(oneHalf > .nan)
    }
    
    func testIntegerInitialization() {
        let a = Fraction(exactly: 3)
        
        XCTAssertEqual(a?.numerator, 3)
        XCTAssertEqual(a?.denominator, 1)
        
        XCTAssertEqual(a, 3)
    }
    
    func testMagnitude() {
        let a: Fraction = "-1/2"
        XCTAssertEqual(a.magnitude, "1/2")
    }
    
    
    // MARK: - This is amazing!!!
    func testSummationWithLiterals() {
        let d: Fraction = "1/3" + "1/3" + "1/3"
        XCTAssertEqual(d, 1)
    }
    
    func testMultiplyAndAssign() {
        var a: Fraction = "3/4"
        a *= "1/2"
        XCTAssertEqual(a, "3/8")
    }

}

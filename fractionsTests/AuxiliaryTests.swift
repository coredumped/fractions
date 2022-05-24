//
//  AuxiliaryTests.swift
//  fractionsTests
//
//  Created by Juan Guerrero on 05/23/22.
//

import XCTest

class AuxiliaryTests: XCTestCase {

    func testGCD() {
        XCTAssertEqual(gcd(100, 35), 5)
        XCTAssertEqual(gcd(33, 300), 3)
        XCTAssertEqual(gcd(325, 1053), 13)
        XCTAssertEqual(gcd(33, -300), 3)
        XCTAssertEqual(gcd(54, 27), 27)
        XCTAssertEqual(gcd(100, 1), 1)
        XCTAssertEqual(gcd(-22, 15024), 2)
    }

    func testLCM() {
        XCTAssertEqual(lcm(54, 27), 54)
        XCTAssertEqual(lcm(27, 108), 108)
        XCTAssertEqual(lcm(90, 342), 1710)
        XCTAssertEqual(lcm(100, 1), 100)
    }
}

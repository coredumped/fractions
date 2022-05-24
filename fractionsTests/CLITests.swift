//
//  CLITests.swift
//  fractionsTests
//
//  Created by Juan Guerrero on 05/24/22.
//

import XCTest

class CLITests: XCTestCase {
    
    var commandLine: CLI!
    let cliService = MockCommandLineService()
    
    override func setUp() {
        commandLine = CLI(cli: cliService)
    }

    func testCLIDisplaysInstructions() {
        commandLine.run()
        XCTAssertEqual(cliService.itemsPrinted.first, "Type the word `exit` to exit")
    }
    
    func testCLITerminatesOnExit() {
        cliService.userInput = ["exit"]
        commandLine.run()
        XCTAssertTrue(cliService.itemsPrinted.contains("Bye bye"))
    }
    
    func testCLIMultiplication () {
        cliService.userInput = [ "2/4 * 4/2", "exit" ].reversed()
        commandLine.run()
        let result = cliService.itemsPrinted[2]
        XCTAssertEqual(result, "= 1")
    }
    
    func testCLIAddition () {
        cliService.userInput = [ "1_1/3 + -1/3", "exit" ].reversed()
        commandLine.run()
        let result = cliService.itemsPrinted[2]
        XCTAssertEqual(result, "= 1")
    }
    
    func testInvalidExpression() {
        cliService.userInput = [ "1_1_3 + -1/3", "exit" ].reversed()
        commandLine.run()
        let result = cliService.itemsPrinted[2]
        XCTAssertEqual(result, "Invalid expression, try again")
    }
}

class MockCommandLineService: CommandLineServiceProtocol {
    var userInput: [String] = []
    var itemsPrinted: [String] = []
        
    func readLine() -> String? {
        return userInput.popLast()
    }
    
    func print(_ items: Any..., separator: String = " ", terminator: String = "\n") {
        itemsPrinted.append(contentsOf: items.map { "\($0)" })
    }
}

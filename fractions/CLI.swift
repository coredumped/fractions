//
//  CLI.swift
//  fractions
//
//  Created by Juan Guerrero on 05/23/22.
//

import Foundation

struct CLI {
    var cli: CommandLineServiceProtocol
        
    func run() {
        cli.print("Type the word `exit` to exit")
        repeat {
            cli.print("?", terminator: "")
            guard let line = cli.readLine(), line != "exit" else { break }
            
            guard let expression = ArithmeticExpression.parse(string: line) else {
                cli.print("Invalid expression, try again")
                continue
            }
            
            let result = expression.evaluate()
            
            cli.print("= \(result)")
        } while true
        cli.print()
        cli.print("Bye bye")
    }
}

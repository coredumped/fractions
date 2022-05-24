//
//  CommandLineService.swift
//  fractions
//
//  Created by Juan Guerrero on 05/23/22.
//

import Foundation

protocol CommandLineServiceProtocol {
    func readLine() -> String?
    func print(_ items: Any..., separator: String, terminator: String)
}

extension CommandLineServiceProtocol {
    func print(_ items: Any...) {
        print(items, separator: " ", terminator: "\n")
    }
    
    func print(_ items: Any..., terminator: String) {
        print(items, separator: " ", terminator: terminator)
    }
}

struct CommandLineService: CommandLineServiceProtocol {
    func readLine() -> String? {
        return Swift.readLine(strippingNewline: true)
    }
    
    func print(_ items: Any..., separator: String = " ", terminator: String = "\n") {
        for item in items {
            Swift.print(item, terminator: "")
            Swift.print(separator, terminator: "")
        }
        Swift.print("", terminator: terminator)
    }
}

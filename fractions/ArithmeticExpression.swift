//
//  ArithmeticExpression.swift
//  fractions
//
//  Created by Juan Guerrero on 05/23/22.
//

import Foundation

enum ArithmeticOperation: String {
    case sum = "+"
    case substract = "-"
    case multiply = "*"
    case divide = "/"
}

struct ArithmeticExpression {
    var a: Fraction
    var operation: ArithmeticOperation
    var b: Fraction
    
    static func parse(string expression: String) -> ArithmeticExpression? {
        guard let a = parseFraction(string: expression, index: expression.startIndex) else {
            return nil
        }
        guard let oper = parseOperator(string: expression, index: a.nextIndex) else {
            return nil
        }
        guard let b = parseFraction(string: expression, index: oper.nextIndex) else {
            return nil
        }
        //Make sure we only support 2 operands
        var currentIndex = b.nextIndex
        while currentIndex != expression.endIndex {
            if expression[currentIndex] != " " {
                return nil
            }
            currentIndex = expression.index(after: currentIndex)
        }
        return ArithmeticExpression(a: a.fraction, operation: oper.oper, b: b.fraction)
    }
    
    static func parseFraction(string fraction: String) -> (fraction: Fraction, nextIndex: String.Index)? {
        return parseFraction(string: fraction, index: fraction.startIndex)
    }
    
    static func parseFraction(string: String, index startIndex: String.Index) -> (fraction: Fraction, nextIndex: String.Index)? {
        var sign = 1
        var whole: Int?
        var numerator = 0
        var currentIndex = startIndex
        //Trim preceeding spaces
        while string[currentIndex] == " " {
            currentIndex = string.index(after: currentIndex)
        }
        
        //Find out fraction sign
        switch string[currentIndex] {
        case "+":
            //Ignore postive sign
            currentIndex = string.index(after: currentIndex)
            break
        case "-":
            sign = -1
            currentIndex = string.index(after: currentIndex)
        default:
            break
        }
        
        
        //Parse first number
        let temp = parseUnsignedInteger(string: string, index: currentIndex, delimiters: ["_", "/"])
        guard let parsedNumber = temp.integer else {
            return nil
        }
        currentIndex = temp.nextIndex
        
        switch string[currentIndex] {
        case "_":
            whole = parsedNumber * sign
        case "/":
            numerator = parsedNumber * sign
        default:
            return nil
        }
        currentIndex = string.index(after: currentIndex)
        
        guard let whole = whole else {
            //Proper improper
            let temp = parseUnsignedInteger(string: string, index: currentIndex)
            if let denominator = temp.integer {
                return (fraction: Fraction(numerator, denominator), nextIndex: temp.nextIndex)
            }
            return nil
        }
        
        //Get numerator for mixed fraction
        var tempN = parseUnsignedInteger(string: string, index: currentIndex, delimiters: ["/"])
        guard let numerator = tempN.integer else {
            return nil
        }
        currentIndex = tempN.nextIndex
        
        guard currentIndex != string.endIndex, string[currentIndex] == "/" else {
            return nil
        }
        currentIndex = string.index(after: currentIndex)

        tempN = parseUnsignedInteger(string: string, index: currentIndex)
        guard let denominator = tempN.integer else {
            return nil
        }
        return (fraction: Fraction(whole: whole, numerator: numerator, denominator: denominator).simplified(),
                nextIndex: tempN.nextIndex)
    }
    
    static func parseUnsignedInteger(string: String, index startIndex: String.Index, delimiters: [Character] = []) -> (integer: Int?, nextIndex: String.Index) {
        var numericString: String = ""
        var currentIndex = startIndex
        
        //Eat zero padding
        while currentIndex != string.endIndex, string[currentIndex] == "0" {
            currentIndex = string.index(after: currentIndex)
            if numericString.isEmpty {
                numericString = "0"
            }
        }
        
        while currentIndex != string.endIndex {
            let character = string[currentIndex]
            if delimiters.contains(character) || character == " " {
                break
            }
            switch character {
            case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
                numericString.append(character)
                currentIndex = string.index(after: currentIndex)
            default:
                return (integer: nil, nextIndex: currentIndex)
            }
        }
        
        return (integer: Int(numericString), nextIndex: currentIndex)
    }
    
    static func parseOperator(string: String, index startIndex: String.Index) -> (oper: ArithmeticOperation, nextIndex: String.Index)? {
        var currentIndex = startIndex
        while string[currentIndex] == " " {
            currentIndex = string.index(after: currentIndex)
        }
        guard let oper = ArithmeticOperation(rawValue: string[currentIndex].description) else {
            return nil
        }
        return (oper: oper, nextIndex: string.index(after: currentIndex))
    }
    
    func evaluate() -> Fraction {
        switch operation {
        case .sum:
            return a + b
        case .substract:
            return a - b
        case .multiply:
            return a * b
        case .divide:
            return a / b
        }
    }
}

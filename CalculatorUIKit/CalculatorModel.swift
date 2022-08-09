//
//  CalculatorModel.swift
//  CalculatorUIKit
//
//  Created by teddy juhlin-henricson on 2022-08-09.
//

import Foundation

// The CalculatorModel handles all the logic of the calculator: operations and show the result

struct CalculatorModel {
    enum Number: String {
        case zero = "0"
        case one = "1"
        case two = "2"
        case three = "3"
        case four = "4"
        case five = "5"
        case six = "6"
        case seven = "7"
        case eight = "8"
        case nine = "9"
        case punct = "."
        case none = ""
    }
    
    enum Operation {
        case addition, subtraction, multiplication, division, percentage
        case clear, equal
        case none
        
        init(_ operation: String?) {
            guard let operation = operation else {
                self = .none
                return
            }
            
            switch operation {
            case "+":
                self = .addition
            case "-":
                self = .subtraction
            case "*":
                self = .multiplication
            case "÷":
                self = .division
            default:
                self = .none
            }
        }
    }
    
    private(set) var input1: String?
    private(set) var input2: String?
    private(set) var currentOperation: Operation = Operation.none
    
    private var result: Double? {
        guard let input1 = Double(input1!),
              let input2 = Double(input2!) else {
            return nil
        }
        
        switch currentOperation {
        case .addition:
            return input1 + input2
        case .subtraction:
            return input1 - input2
        case .multiplication:
            return input1 * input2
        case .division:
            return input2 != 0 ? input1 / input2 : 0
        default:
            return nil
        }
    }
    
    mutating func appendInput1(_ input: String) {
        input1?.append(input)
    }
    
    mutating func appendInput2(_ input: String) {
        input2?.append(input)
    }
    
    mutating func setInput(_ input: String) {
        if currentOperation == .none {
            if input1 == nil {
                input1 = input
            } else {
                appendInput1(input)
            }
        } else {
            if input2 == nil {
                input2 = input
            } else {
                appendInput2(input)
            }
        }
    }
    
    mutating func setOperation(_ operation: Operation) {
        switch operation {
        case .equal:
            input1 = String(result ?? 0)
            input2 = nil
        case .clear:
            input1 = nil
            input2 = nil
            currentOperation = .none
        default:
            if input1 != nil && input2 != nil {
                input1 = String(result ?? 0)
                input2 = nil
            } else {
                currentOperation = operation
            }
        }
    }
}

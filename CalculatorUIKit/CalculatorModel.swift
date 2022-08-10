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
    
    private(set) var input1: String? = "0"
    private(set) var input2: String?
    private(set) var currentOperation: Operation = Operation.none
    private var resetLabel: Bool = true
    
    private var result: Double? {
        guard let input1 = Double(input1!) else {
            return nil
        }
        
        if currentOperation == .percentage {
            return input1 / 100
        }
        
        guard let input2 = Double(input2!) else {
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
        case .percentage:
            return input1 / 100
        default:
            return nil
        }
    }
    
    mutating func appendInput(for oldInput: String?, with newInput: String) {
        switch oldInput {
        case input1:
            if input1!.count < 9 {
                input1?.append(newInput)
            }
        default:
            if input2!.count < 9 {
                input2?.append(newInput)
            }
        }
    }
    
    mutating func setInput(_ newInput: String) {
        switch currentOperation {
        case .none:
            if resetLabel {
                input1 = newInput
                resetLabel = false
            } else {
                appendInput(for: input1, with: newInput)
            }
        default:
            if input2 == nil || input2 == "0" {
                input2 = newInput
            } else {
                appendInput(for: input2, with: newInput)
            }
        }
    }
    
    mutating func setOperation(_ operation: Operation) {
        switch operation {
        case .equal:
            clearAll(exceptInput1: result)
            resetLabel = true
        case .clear:
            clearAll()
            resetLabel = true
        case .percentage:
            currentOperation = operation
            clearAll(exceptInput1: result)
        default:
            if input1 != nil && input2 != nil {
                clearAll(exceptInput1: result, exceptOperations: operation)
            } else {
                currentOperation = operation
            }
        }
    }
    
    private func removeTrailingZeroes(_ temp: Double?) -> String {
        return String(format: "%g", temp ?? 0)
    }
    
    mutating private func clearAll(exceptInput1 input1: Double? = 0,
                                   exceptInput2 input2: Double? = nil,
                                   exceptOperations currentOperation: Operation = .none) {
        self.input1 = input1 != nil ? removeTrailingZeroes(input1) : nil
        self.input2 = input2 != nil ? removeTrailingZeroes(input2) : nil
        self.currentOperation = currentOperation
    }
}

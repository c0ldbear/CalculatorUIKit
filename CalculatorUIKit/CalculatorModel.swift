//
//  CalculatorModel.swift
//  CalculatorUIKit
//
//  Created by teddy juhlin-henricson on 2022-08-09.
//

import Foundation

// The CalculatorModel handles all the logic of the calculator: operations and show the result

final class CalculatorModel {
    enum Operation {
        case addition, subtraction, multiplication, division
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
    
    private var input1: Double?
    private var input2: Double?
    private var currentOperation: Operation? = Operation.none
    
    private var result: Double? {
        guard let input1 = input1,
              let input2 = input2 else {
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
    
    func setInput(_ input: Double?) {
        if input1 == nil {
            input1 = input
        }
        
        if input2 == nil {
            input2 = input
        }
    }
    
    func setOperation(_ operation: Operation?) {
        if let operation = operation {
            currentOperation = operation
        }
    }
}

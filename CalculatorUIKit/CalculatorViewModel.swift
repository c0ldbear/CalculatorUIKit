//
//  CalculatorViewModel.swift
//  CalculatorUIKit
//
//  Created by teddy juhlin-henricson on 2022-08-08.
//

import Foundation
import UIKit

final class CalculatorViewModel: ObservableObject {
    
    enum CalculatorButton {
        case operation(CalculatorModel.Operation)
        case number(CalculatorModel.Number)
        
        static let allButtons: [[CalculatorButton]] = [[ .operation(.clear), .operation(.percentage), .operation(.division)],
                                                       [.number(.seven), .number(.eight), .number(.nine), .operation(.multiplication)],
                                                       [.number(.four), .number(.five), .number(.six), .operation(.subtraction)],
                                                       [.number(.one), .number(.two), .number(.three), .operation(.addition)],
                                                       [.number(.zero), .number(.punct), .operation(.equal)]]
        
        var string: String {
            switch self {
            case .operation(let operation):
                return stringFromOperation(operation)
            case .number(let number):
                return number.rawValue
            }
        }
        
        func stringFromOperation(_ operation: CalculatorModel.Operation) -> String {
            switch operation {
            case .multiplication:
                return "x"
            case .division:
                return "÷"
            case .addition:
                return "+"
            case .subtraction:
                return "-"
            case .percentage:
                return "%"
            case .clear:
                return "c"
            case .equal:
                return "="
            default:
                return ""
            }
        }
        
        func stringFromNumber(_ number: CalculatorModel.Number) -> String  {
            switch number {
            case .zero:
                return "0"
            case .one:
                return "1"
            case .two:
                return "2"
            case .three:
                return "3"
            case .four:
                return "4"
            case .five:
                return "5"
            case .six:
                return "6"
            case .seven:
                return "7"
            case .eight:
                return "8"
            case .nine:
                return "9"
            case .punct:
                return "."
            case .none:
                return ""
            }
        }
    }
        
    @Published private(set) var calculatorModel = CalculatorModel()
    
    init() {}
    
    func pressed(_ calculatorButton: CalculatorButton) {
        switch calculatorButton {
        case .number(let number):
            calculatorModel.setInput(number.rawValue)
        case .operation(let operation):
            calculatorModel.setOperation(operation)
        }
    }
}

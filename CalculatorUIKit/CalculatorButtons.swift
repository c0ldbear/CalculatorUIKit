//
//  CalculatorButtons.swift
//  CalculatorUIKit
//
//  Created by teddy juhlin-henricson on 2022-08-09.
//

import Foundation
import UIKit

extension UIButton {
    enum CalculatorButtons: String {
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
        case clear = "c"
        case addition = "+"
        case subtraction = "-"
        case multiplication = "*"
        case division = "÷"
        case percentage = "%"
        case equal = "="
        case punct = "."
        case none = ""
    }
    
    var calcButton: CalculatorButtons? {
        return CalculatorButtons(rawValue: self.currentTitle!)
    }
}

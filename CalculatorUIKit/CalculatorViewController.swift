//
//  ViewController.swift
//  CalculatorUIKit
//
//  Created by teddy juhlin-henricson on 2022-07-29.
//

import UIKit
import Combine

class CalculatorViewController: UIViewController {
    
    @IBOutlet var showNumbersLabel: UILabel!
    @IBOutlet var vStack: UIStackView!
    @IBOutlet var firstRow: UIStackView!
    @IBOutlet var secondRow: UIStackView!
    @IBOutlet var thirdRow: UIStackView!
    @IBOutlet var fourthRow: UIStackView!
    @IBOutlet var fifthRow: UIStackView!
    
    private let calculatorViewModel = CalculatorViewModel()
    private var cancellable: AnyCancellable?
    
    var buttonColors: [UIColor] = [ .systemCyan, .systemMint, .systemPink, .systemTeal, .systemIndigo ]
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cancellable = calculatorViewModel.$calculatorModel.sink { [weak self] calculatorModel in
            guard let weakSelf = self else {
                return
            }
            weakSelf.updateForCalculatorModel(for: calculatorModel)
        }
        
        setupNumbersLabel()
        addButtonsToStackViews()
    }
    
    func addButtonsToStackViews() {
        let rows: [UIStackView?] = [firstRow, secondRow, thirdRow, fourthRow, fifthRow]
        
        for (row, calculatorButtons) in zip(rows, CalculatorViewModel.allButtons) {
            for calculatorButton in calculatorButtons {
                let button = setupButton(with: calculatorButton, withAction: {
                    self.calculatorViewModel.pressed(calculatorButton)
                })
                row?.spacing = 10
                row?.addArrangedSubview(button)
            }
        }
    }
    
    func setupButton(with buttonType: CalculatorViewModel.CalculatorButton, withAction action: @escaping () -> Void) -> UIButton {
        let title = buttonType.string
        let button = UIButton(type: .custom, primaryAction: UIAction(title: title, handler: { [weak self] 🎬 in
            guard let weakSelf = self,
                  let button = 🎬.sender as? UIButton,
                  let buttonTitle = button.currentTitle else {
                return
            }
            
            if ".0123456789".contains(buttonTitle) {
                button.backgroundColor = weakSelf.randomisedBackgroundColor()
            }
            action()
        }))
        
        button.frame = CGRect(x: 5, y: 5, width: 65, height: 65)
        button.layer.cornerRadius = Double.pi/2 * button.bounds.size.width
        button.clipsToBounds = true
        switch buttonType {
        case .operation:
            button.backgroundColor = .systemBrown
        case .number:
            button.backgroundColor = .systemFill
        }
        button.setTitle(title, for: .normal)
        
        return button
    }
    
    func randomisedBackgroundColor() -> UIColor? {
        return buttonColors.shuffled().first
    }
    
    func setupNumbersLabel() {
        showNumbersLabel.font = .monospacedDigitSystemFont(ofSize: 32, weight: .bold)
        showNumbersLabel.text = "0"
        showNumbersLabel.numberOfLines = 2
    }
    
    func updateForCalculatorModel(for calculatorModel: CalculatorModel) {
        let currentOperationString = CalculatorViewModel.CalculatorButton.operation(calculatorModel.currentOperation).string
        let firstInput: String = "\(calculatorModel.input1 ?? "")"
        let secondInput: String = "\(calculatorModel.input2 ?? "")"
        
        showNumbersLabel.text = "\(firstInput) \(currentOperationString) \(secondInput)"
    }
    
}

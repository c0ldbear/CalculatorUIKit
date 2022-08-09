//
//  ViewController.swift
//  CalculatorUIKit
//
//  Created by teddy juhlin-henricson on 2022-07-29.
//

import UIKit
import Combine

class CalculatorViewController: UIViewController, CalculatorViewControllerDelegate  {
    
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
        // Do any additional setup after loading the view.
        
        cancellable = calculatorViewModel.$calculatorModel.sink { calculatorModel in
            
            self.updateForCalculatorModel(for: calculatorModel)
            
        }
        
        setupNumbersLabel()
        addButtonsToStackViews()
    }
    
    @objc
    func buttonAction(for button: UIButton?) {
        guard let button = button,
              let title = button.currentTitle else {
            return
        }
        
        button.backgroundColor = randomisedBackgroundColor()
        
        if calculatorViewModel.firstTime {
            calculatorViewModel.setFirstTime(false)
            showNumbersLabel.text = title
            return
        }
        
        if showNumbersLabel.text!.count < 10 {
            showNumbersLabel.text! += button.currentTitle ?? ""
        }
    }
    
    func addButtonsToStackViews() {
        let rows: [UIStackView?] = [firstRow, secondRow]
        
        for (row, calculatorButtons) in zip(rows, CalculatorViewModel.CalculatorButton.allButtons) {
            for calculatorButton in calculatorButtons {
                let button = setupButton(withTitle: calculatorButton.string, withAction: {self.calculatorViewModel.pressed(calculatorButton)})
                row?.spacing = 10
                row?.addArrangedSubview(button)
            }
        }
    }
    
    
    func setupButton(withTitle title: String, withAction action: @escaping () -> ()) -> UIButton {
        let button = UIButton(type: .custom, primaryAction: UIAction(title: title, handler: {_ in
            action()
        }))
        
        button.frame = CGRect(x: 5, y: 5, width: 65, height: 65)
        button.layer.cornerRadius = Double.pi/2 * button.bounds.size.width
        button.clipsToBounds = true
        button.backgroundColor = .systemFill
        button.setTitle(title, for: .normal)
        
        return button
    }
    
    func randomisedBackgroundColor() -> UIColor? {
        return buttonColors.shuffled().first
    }
    
    func setupNumbersLabel() {
        showNumbersLabel.font = .monospacedDigitSystemFont(ofSize: 32, weight: .bold)
        showNumbersLabel.text = "0"
        showNumbersLabel.numberOfLines = 10
    }
    
    func updateForCalculatorModel(for calculatorModel: CalculatorModel) {
        showNumbersLabel.text = calculatorModel.input2 ?? calculatorModel.input1 ?? "0"
    }
    
}


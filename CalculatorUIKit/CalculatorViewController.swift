//
//  ViewController.swift
//  CalculatorUIKit
//
//  Created by teddy juhlin-henricson on 2022-07-29.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    @IBOutlet var showNumbersLabel: UILabel!
    @IBOutlet var vStack: UIStackView!
    @IBOutlet var firstRow: UIStackView!
    @IBOutlet var secondRow: UIStackView!
    @IBOutlet var thirdRow: UIStackView!
    @IBOutlet var fourthRow: UIStackView!
    @IBOutlet var fifthRow: UIStackView!
    
    private var result: Double = 0.0
    var firstTime: Bool = true
    var buttonColors: [UIColor] = [ .systemCyan, .systemMint, .systemPink, .systemTeal, .systemIndigo ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupNumbersLabel()
        addButtonsToStackViews()
    }
    
    @objc
    func buttonAction(for button: UIButton?) {
        guard let button = button else {
            return
        }
        
        button.backgroundColor = randomisedBackgroundColor()
        
        if firstTime {
            firstTime = false
            showNumbersLabel.text = button.currentTitle
            return
        }
        
        if showNumbersLabel.text!.count < 10 {
            showNumbersLabel.text! += button.currentTitle ?? ""
        }
    }
    
    func randomisedBackgroundColor() -> UIColor? {
        return buttonColors.shuffled().first
    }
    
    func addButtonsToStackViews() {
        let rows: [UIStackView?] = [firstRow, secondRow, thirdRow, fourthRow, fifthRow] //  TODO: Add programmatically?
        let allButtons: [[UIButton.CalculatorButtons]] = [[.clear, .percentage, .division],
                                                 [.seven, .eight, .nine, .multiplication],
                                                 [.four, .five, .six, .subtraction],
                                                 [.one, .two, .three, .addition],
                                                 [.zero, .punct, .equal]]
        
        for (row, numbers) in zip(rows, allButtons) {
            for number in numbers {
                let button = UIButton(type: .custom)
                setupButton(for: button, withTitle: number.rawValue)
                row?.spacing = 10
                row?.addArrangedSubview(button)
            }
        }
    }
    
    func setupButton(for button: UIButton?, withTitle title: String?) {
        guard let button = button else {
            return
        }
        
        button.frame = CGRect(x: 5, y: 5, width: 65, height: 65)
        button.layer.cornerRadius = Double.pi/2 * button.bounds.size.width
        button.clipsToBounds = true
        button.backgroundColor = .systemFill
        button.setTitle(title, for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    func setupNumbersLabel() {
        showNumbersLabel.font = .monospacedDigitSystemFont(ofSize: 32, weight: .bold)
//        showNumbersLabel.text = "LOLs will be shown here\n\nlol"
        showNumbersLabel.text = "0"
        showNumbersLabel.numberOfLines = 10
    }
}

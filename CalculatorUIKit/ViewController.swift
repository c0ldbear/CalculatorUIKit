//
//  ViewController.swift
//  CalculatorUIKit
//
//  Created by teddy juhlin-henricson on 2022-07-29.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var showNumbersLabel: UILabel!
    @IBOutlet var testButton: UIButton!
    @IBOutlet var testButton2: UIButton!
    @IBOutlet var testButton3: UIButton!
    @IBOutlet var testButton4: UIButton!
    @IBOutlet var testButton5: UIButton!
    @IBOutlet var testButton6: UIButton!
    @IBOutlet var testButton7: UIButton!
    @IBOutlet var testButton8: UIButton!
    @IBOutlet var testButton9: UIButton!
    
    var firstTime: Bool = true
    var buttonColors: [UIColor] = [ .systemCyan, .systemMint, .systemPink, .systemTeal, .systemIndigo ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupNumbersLabel()
        
        let buttons: [UIButton?] = [testButton, testButton2, testButton3, testButton4, testButton5, testButton6, testButton7, testButton8, testButton9]
        let titles: [String?] = ["LåL", "LöL", "LäL", "LøL", "LæL", "LaaL", "Que", "LooL", "LaoL"]
        
        for (button, title) in zip(buttons, titles) {
            setupTestButton(for: button, withTitle: title)
        }
    }
    
    @objc
    func buttonAction(for button: UIButton?) {
        guard let button = button else {
            return
        }
        
        button.configuration?.background.backgroundColor = buttonColors.shuffled().first
        
        if firstTime {
            firstTime = false
            showNumbersLabel.text = button.currentTitle
            return
        }
        showNumbersLabel.text! += button.currentTitle ?? ""
        
    }
    
    func setupTestButton(for button: UIButton?, withTitle title: String?) {
        guard let button = button else {
            return
        }
        
        button.setTitle(title, for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    func setupNumbersLabel() {
        showNumbersLabel.text = "LOLs will be shown here\n\nlol"
        showNumbersLabel.numberOfLines = 10
    }
}

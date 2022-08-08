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
    
    var firstTime: Bool = true
    var buttonColors: [UIColor] = [ .systemCyan, .systemMint, .systemPink, .systemTeal, .systemIndigo ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupNumbersLabel()
        
        let rows: [UIStackView?] = [firstRow, secondRow, thirdRow]
        let allTitles: [[String?]] = [["LåL", "LöL", "LäL"],
                                   ["LøL", "LæL", "LaaL", "Que"],
                                   [ "LooL", "LaoL"]]
        
        for (row, titles) in zip(rows, allTitles) {
            for title in titles {
                let button = UIButton(type: .custom)
                button.frame = CGRect(x: 5, y: 5, width: 65, height: 65)
                button.layer.cornerRadius = 2 * button.bounds.size.width
                button.clipsToBounds = true
                button.backgroundColor = .systemFill
                button.setTitle(title, for: .normal)
                button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
                row?.spacing = 15
                row?.addArrangedSubview(button)
            }
        }
        
    }
    
    @objc
    func buttonAction(for button: UIButton?) {
        guard let button = button else {
            return
        }
        
        button.backgroundColor = buttonColors.shuffled().first
        
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

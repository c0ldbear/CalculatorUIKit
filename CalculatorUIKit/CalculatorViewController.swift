//
//  ViewController.swift
//  CalculatorUIKit
//
//  Created by teddy juhlin-henricson on 2022-07-29.
//

import UIKit

class ViewController: UIViewController {
    
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
//                let button = UIButton(frame: CGRect(x: 15, y: 5, width: 150, height: 55))
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
        
//        for (button, title) in zip(buttons, titles.reversed()) {
//            setupTestButton(for: button, withTitle: title)
//        }
    }
    
    @objc
    func buttonAction(for button: UIButton?) {
        guard let button = button else {
            return
        }
        
//        button.configuration?.background.backgroundColor = buttonColors.shuffled().first
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

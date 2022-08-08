//
//  ViewController.swift
//  CalculatorUIKit
//
//  Created by teddy juhlin-henricson on 2022-07-29.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var showNumbersLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let button = UIButton(frame: CGRect(x: 100,
                                            y: 100,
                                            width: 200,
                                            height: 60))
        button.setTitle("Test", for: .normal)
        button.setTitleColor(.systemCyan, for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(button)
        
    }
    
    @objc
    func buttonAction() {
        print("Button pressed!")
        showNumbersLabel.text = "LOL"
    }
    
}


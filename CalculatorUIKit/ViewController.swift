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
    
    private var pressed: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTestButton()
    }
    
    @objc
    func buttonAction() {
        pressed = !pressed
        showNumbersLabel.text = pressed ? "LOL" : "Label"
    }
    
    func setupTestButton() {
        testButton.setTitle("test", for: .normal)
        testButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
}


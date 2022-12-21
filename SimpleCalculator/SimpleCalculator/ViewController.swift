//
//  ViewController.swift
//  SimpleCalculator
//
//  Created by AnilyTugce on 30.08.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var firstText: UITextField!
    @IBOutlet weak var secondText: UITextField!
    @IBOutlet weak var resultText: UILabel!
    
    var result = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func sumClicked(_ sender: Any) {
        
        
        if let firstNum = Int(firstText.text!) {
            if let secondNum = Int(secondText.text!) {
                result = firstNum + secondNum
                resultText.text = String(result)
            }
        }
        
    }
    
    @IBAction func minusClicked(_ sender: Any) {
        if let firstNum = Int(firstText.text!) {
            if let secondNum = Int(secondText.text!) {
                result = firstNum - secondNum
                resultText.text = String(result)
            }
        }
    }
    
    @IBAction func multiplyClicked(_ sender: Any) {
        if let firstNum = Int(firstText.text!) {
            if let secondNum = Int(secondText.text!) {
                result = firstNum * secondNum
                resultText.text = String(result)
            }
        }
    }
    
    @IBAction func divideClicked(_ sender: Any) {
        if let firstNum = Int(firstText.text!) {
            if let secondNum = Int(secondText.text!) {
                result = firstNum / secondNum
                resultText.text = String(result)
            }
        }
    }
    
}


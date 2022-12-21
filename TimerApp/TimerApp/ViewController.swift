//
//  ViewController.swift
//  TimerApp
//
//  Created by AnilyTugce on 1.09.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    var count = 10
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = "Time : \(count)"
      
        
    
    }
    
    @objc func startTimer (){
        label.text = "Time : \(count)"
        count -= 1
        
        if count < 0 {
            label.text = "Time is up"
        }
    }

    
    @IBAction func buttonClicked(_ sender: Any) {
        count = 10
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(startTimer), userInfo: nil, repeats: true)
    }
    
}


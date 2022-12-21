//
//  ViewController.swift
//  SegueApp
//
//  Created by AnilyTugce on 31.08.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var infoTextField: UITextField!
    
    var myInfo = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func next(_ sender: Any) {
        myInfo = infoTextField.text!
        performSegue(withIdentifier: "toSecondVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSecondVC" {
            let destinationVC = segue.destination as! SecondViewController
            destinationVC.myNameInfo = myInfo
        }
    }
    
}


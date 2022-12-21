//
//  ViewController.swift
//  Alert App
//
//  Created by AnilyTugce on 1.09.2022.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func signUp(_ sender: Any) {
        
        if nameTextField.text == "" || passwordTF.text == "" || confirmPasswordTF.text == ""{
            showAlert(title: "Missing Info/s", message: "Please make sure that all info is written.")
        }else{
            if passwordTF.text == confirmPasswordTF.text {
                showAlert(title: "SIGN UP", message: "Completed")
            }else{
                showAlert(title: "SIGN UP", message: "Failed. Passwords don't match")
            }
        }
        
     
        
    }
    
    func showAlert(title : String, message : String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { UIAlertAction in
            print("clicked")
        }
        
        alert.addAction(okButton)
        
        self.present(alert, animated: true)
    }
    
}


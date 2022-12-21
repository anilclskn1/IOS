//
//  ViewController.swift
//  InstaFirebaseApp
//
//  Created by AnilyTugce on 20.09.2022.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
    }

    @IBAction func signInClicked(_ sender: Any) {
        if emailTextField.text != nil && passwordTextField.text != nil {
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { authDataResult, error in
                if error != nil {
                    self.showAlert(title: "ERROR", message: error?.localizedDescription ?? "Error")
                } else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        }
       
    }
    
    
    @IBAction func signUpClicked(_ sender: Any) {
        
        if emailTextField.text != "" && passwordTextField.text != "" {
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { authDataResult, error in
                
                if error != nil {
                    self.showAlert(title: "ERROR", message: error?.localizedDescription ?? "Error")
                } else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
                
            }
        } else {
            showAlert(title: "ERROR", message: "Email/Password missing")
        }
        
    }
    
    
    func showAlert(title: String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let button = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(button)
        present(alert, animated: true, completion: nil)
    }
    
}


//
//  ViewController.swift
//  FourSquareClone
//
//  Created by AnilyTugce on 23.09.2022.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }
    
    @IBAction func signInClicked(_ sender: Any) {
        
        if userNameTextField.text != "" && passwordTextField.text != "" {
            
            PFUser.logInWithUsername(inBackground: userNameTextField.text!, password: passwordTextField.text!) { user, error in
                if error != nil {
                    self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
                } else {
                    self.performSegue(withIdentifier: "toPlacesVC", sender: nil)
                }
            }
            
        } else {
            makeAlert(title: "Error", message: "username/password missing")
        }
        
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        if userNameTextField.text == "" && passwordTextField.text == "" {
            makeAlert(title: "Error", message: "username/password missing")
        } else {
            let user = PFUser()
            user.username = userNameTextField.text!
            user.password = passwordTextField.text!
            user.signUpInBackground { success, error in
                if error != nil {
                    self.makeAlert(title: "Error", message: error!.localizedDescription)
                } else {
                    self.performSegue(withIdentifier: "toPlacesVC", sender: nil)
                }
            }
        }
    }
    
    func makeAlert(title : String, message : String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
}


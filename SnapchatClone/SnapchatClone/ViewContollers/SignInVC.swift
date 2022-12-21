//
//  ViewController.swift
//  SnapchatClone
//
//  Created by AnilyTugce on 7.10.2022.
//

import UIKit
import Firebase

class SignInVC: UIViewController {
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    let firebaseAuth = Auth.auth()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func singInClicked(_ sender: Any) {
        if emailText.text != "" && passwordText.text != "" {
            
            firebaseAuth.signIn(withEmail: emailText.text!, password: passwordText.text!) { auth, error in
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                } else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
            
        } else {
            makeAlert(titleInput: "Error", messageInput: "Email/Password ?")
        }
    }
    @IBAction func signUpClicked(_ sender: Any) {
        if emailText.text != "" && usernameText.text != "" && passwordText.text != "" {
            
            
            firebaseAuth.createUser(withEmail: emailText.text!, password: passwordText.text!) { auth, error in
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                }else {
                    let firebaseFirestore = Firestore.firestore()
                    let info = ["email" : self.emailText.text!, "username" : self.usernameText.text!] as [String : Any]
                    firebaseFirestore.collection("UserInfo").addDocument(data: info) { error in
                        if error != nil {
                            self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                        } else {
                            self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                        }
                    }
                }
            }
            
        }else {
            makeAlert(titleInput: "Error", messageInput: "Email/Username/Password ?")
        }
    }
    
    func makeAlert(titleInput : String, messageInput : String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    
}


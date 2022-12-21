//
//  SettingsViewController.swift
//  InstaFirebaseApp
//
//  Created by AnilyTugce on 20.09.2022.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signOutClicked(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toVC", sender: nil)
        } catch {
            print("error")
        }
    }
    
 
}

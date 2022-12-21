//
//  SettingsVC.swift
//  SnapchatClone
//
//  Created by AnilyTugce on 7.10.2022.
//

import UIKit
import Firebase

class SettingsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func logoutClicked(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toSignInVC", sender: nil)
        } catch {
            
        }
    }
    
}

//
//  ViewController.swift
//  FaceRecognitionApp
//
//  Created by AnilyTugce on 18.09.2022.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {
    
    
    @IBOutlet weak var myLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func signInButton(_ sender: Any) {
        
        //initialize
        let authContext = LAContext()
        
        // we need this
        var error : NSError?
        
        // if user can do this, if phone has this property
        if authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            
            //evaluate it
            authContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Is it you?") { success, error in
                
                if success == true {
                    //DispatchQueue runs the code in main thread
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "toSecondVC", sender: nil)
                    }
                }
                else {
                    DispatchQueue.main.async {
                        self.myLabel.text = "Error"
                    }
                }
                
            }
        }
    }
    
}


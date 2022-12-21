//
//  ViewController.swift
//  BirthdayTakerApp
//
//  Created by AnilyTugce on 30.08.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var birthdayTextFiled: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let storedName = UserDefaults.standard.object(forKey: "name")
        let storedBirthday = UserDefaults.standard.object(forKey: "birthday")
        
        if let name = storedName as? String{
            nameLabel.text = "Stored Name : \(name)"
        }
        
        if let birthday = storedBirthday as? String{
            birthdayLabel.text = "Stored Birthday : \(birthday)"
        }
        
    }

    @IBAction func saveBirth(_ sender: Any) {
        let name = nameTextField.text!
        let birthday = birthdayTextFiled.text!
        
        UserDefaults.standard.set(name, forKey: "name")
        UserDefaults.standard.set(birthday, forKey: "birthday")

        
        nameLabel.text = "Name : \(name)"
        birthdayLabel.text = "Birthday : \(birthday)"
    }
    
    
    
    @IBAction func deleteStoredValue(_ sender: Any) {
        let storedName = UserDefaults.standard.object(forKey: "name")
        
        let storedBirthday = UserDefaults.standard.object(forKey: "birthday")
        
        if  (storedName as? String) != nil {
            UserDefaults.standard.removeObject(forKey: "name")
            nameLabel.text = "Name : "
        }
        if  (storedBirthday as? String) != nil {
            UserDefaults.standard.removeObject(forKey: "birthday")
            birthdayLabel.text = "Birthday : "
        }

    }
    
}


//
//  ViewController.swift
//  MyFirstApp
//
//  Created by AnilyTugce on 27.08.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func onClicked(_ sender: Any) {
        imageView.image = UIImage(named: "tugcerum")
    }
    
}


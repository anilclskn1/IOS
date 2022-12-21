//
//  ViewController.swift
//  GestureRecognizer
//
//  Created by AnilyTugce on 1.09.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    var isMirac = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        label.text = "without Mirac"
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(change))
        imageView.addGestureRecognizer(gestureRecognizer)
        
    }

    
    @objc func change(){
        if isMirac == false {
            imageView.image = UIImage(named : "withMirac")
            label.text = "with Mirac"
            isMirac = true

        }else{
            imageView.image = UIImage(named : "withoutMirac")
            label.text = "without Mirac"
            isMirac = false

    }
    
}
}


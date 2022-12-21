//
//  SecondViewController.swift
//  SegueApp
//
//  Created by AnilyTugce on 31.08.2022.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var nameInfoLablel: UILabel!
    
    var myNameInfo = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameInfoLablel.text = myNameInfo
        // Do any additional setup after loading the view.
    }

}

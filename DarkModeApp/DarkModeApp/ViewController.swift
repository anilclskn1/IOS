//
//  ViewController.swift
//  DarkModeApp
//
//  Created by AnilyTugce on 18.09.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // this view will be in dark mode whatever the arranged mode it is
        overrideUserInterfaceStyle = .dark
    }


    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        let userInterfaceStyle = traitCollection.userInterfaceStyle
        
        if userInterfaceStyle == .dark {
            button.tintColor = .lightGray
        } else {
            button.tintColor = .blue
        }
    }
}


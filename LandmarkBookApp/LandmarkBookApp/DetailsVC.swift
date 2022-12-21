//
//  DetailsVC.swift
//  LandmarkBookApp
//
//  Created by AnilyTugce on 2.09.2022.
//

import UIKit

class DetailsVC: UIViewController {

    @IBOutlet weak var selectedImage: UIImageView!
    @IBOutlet weak var selectedName: UILabel!
    
    var image = UIImage()
    var name = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        selectedName.text = name
        selectedImage.image = image
        // Do any additional setup after loading the view.
    }
    



}

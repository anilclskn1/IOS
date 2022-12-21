//
//  detailsController.swift
//  SimpsonApp
//
//  Created by AnilyTugce on 4.09.2022.
//

import UIKit

class detailsController: UIViewController {

    @IBOutlet weak var jobLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var selectedSimpson : Simpsons?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = selectedSimpson?.name
        jobLabel.text = selectedSimpson?.job
        imageView.image = selectedSimpson?.image
        
    }
    

   

}

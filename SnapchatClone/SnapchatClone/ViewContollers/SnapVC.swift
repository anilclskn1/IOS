//
//  SnapVC.swift
//  SnapchatClone
//
//  Created by AnilyTugce on 7.10.2022.
//

import UIKit
import ImageSlideshow

class SnapVC: UIViewController {
    
    var selectedSnap : Snap?
    var inputArray = [KingfisherSource]()
    @IBOutlet weak var timeLeftText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        if let snap = selectedSnap {
            timeLeftText.text = "Time Left: \(snap.timeLeft)"
            for imageUrl in snap.imageUrlArray {
                self.inputArray.append(KingfisherSource(urlString: imageUrl)!)
            }
            
            let imageSlideShow = ImageSlideshow(frame: CGRect(x: 10, y: 10, width: self.view.frame.width * 0.95, height: self.view.frame.height * 0.9))
            
            imageSlideShow.backgroundColor = UIColor.white
            
            let pageIndicator = UIPageControl()
            pageIndicator.currentPageIndicatorTintColor = UIColor.lightGray
            pageIndicator.pageIndicatorTintColor = UIColor.black
            imageSlideShow.pageIndicator = pageIndicator
            
            imageSlideShow.contentScaleMode = UIViewContentMode.scaleAspectFit
            imageSlideShow.setImageInputs(inputArray)
            self.view.addSubview(imageSlideShow)
            self.view.bringSubviewToFront(timeLeftText)
        }
    }
    

}

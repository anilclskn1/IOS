//
//  ViewController.swift
//  CatchTheBatuGame
//
//  Created by AnilyTugce on 1.09.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var bestScoreLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    @IBOutlet weak var imageView5: UIImageView!
    @IBOutlet weak var imageView6: UIImageView!
    @IBOutlet weak var imageView7: UIImageView!
    @IBOutlet weak var imageView8: UIImageView!
    @IBOutlet weak var imageView9: UIImageView!
    
    
    var count = 10
    var timer = Timer()
    var myImageViews = Array<UIImageView>()
    var myImages = Array<String>()
    var imageViewRandom = 0
    var imageRandom = 0
    var score = 0
    var name = ""
    var bestScore = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let bestScore = UserDefaults.standard.object(forKey: "bestScore")
        if let storedBestScore = bestScore as? Int {
            print("first if")
            bestScoreLabel.text = "Best Score : \(storedBestScore)"
        }else {
            print("first else")
            UserDefaults.standard.set(bestScore, forKey: "bestScore")
        }
        
        timerLabel.text = "10"
        scoreLabel.text = "Score : 0"
        myImageViews = [imageView1!, imageView2!, imageView3!, imageView4!, imageView5!, imageView6!, imageView7!, imageView8!, imageView9!]
        myImages = ["anil", "batu", "eto"]
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(startTimer), userInfo: nil, repeats: true)
    }
    
    
    @objc func startTimer() {
        imageViewRandom = Int.random(in: 1 ... 9)
        imageRandom = Int.random(in: 1 ... 3)
        name = myImages[imageRandom - 1]
        self.setVisibilityForImageViews(randromIV : imageViewRandom, randomI : imageRandom)
        print(imageViewRandom)
        timerLabel.text = "\(count)"
        count -= 1
        if count < 0 {
            timer.invalidate()
            showAlert(title: "GAME OVER", message: "Do you want to play again")
        }
    }
    
    func showAlert(title : String, message : String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let button = UIAlertAction(title: "START AGAIN", style: UIAlertAction.Style.default) { UIAlertAction in
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.startTimer), userInfo: nil, repeats: true)
            self.score = 0
            self.scoreLabel.text = "Score : \(self.score)"
        }
        alert.addAction(button)
        self.present(alert, animated: true)
        count = 10
        if score > UserDefaults.standard.object(forKey: "bestScore") as? Int ?? 0 {
            print("second if")
            UserDefaults.standard.set(score, forKey: "bestScore")
        }
      

    }
    
    func setVisibilityForImageViews(randromIV : Int, randomI : Int) {
        let imageV = myImageViews[randromIV - 1]
        let myImage = myImages[randomI - 1]
        for img in 0 ... 8 {
            if img != randromIV - 1 {
                let imageV = myImageViews[img]
                imageV.isHidden = true
                imageV.isUserInteractionEnabled = false
            }else {
                imageV.image = UIImage(named: myImage)
                imageV.isHidden = false
                imageV.isUserInteractionEnabled = true
            }
        }
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.imageClicked))
        imageV.addGestureRecognizer(gestureRecognizer)
        
      
       
    }
    
    @objc func imageClicked() {
        if name == "batu" {
            score += 1
        }else {
                score -= 1
        }
        scoreLabel.text = "Score : \(score)"
    }
}


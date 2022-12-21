//
//  FeedCellViewController.swift
//  InstaFirebaseApp
//
//  Created by AnilyTugce on 21.09.2022.
//

import UIKit
import Firebase

class FeedCellViewController: UITableViewCell {

    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userCommentLabel: UILabel!
    @IBOutlet weak var documentIdLabel: UILabel!
    @IBOutlet weak var userLikeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func likeButtonClicked(_ sender: Any) {
        let firestoreDatabase = Firestore.firestore()
        
        print("   \(userLikeLabel.text!)")
        
        if let likeCount = Int(userLikeLabel.text!) {
            
            let likeStore = ["likes" : likeCount + 1] as [String : Any]
            print("girdi")
            //merge only update given field and does not touch other
            firestoreDatabase.collection("Posts").document(documentIdLabel.text!).setData(likeStore, merge: true)
            
        }
    }
    
}

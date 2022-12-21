//
//  FeedViewController.swift
//  InstaFirebaseApp
//
//  Created by AnilyTugce on 20.09.2022.
//

import UIKit
import Firebase
import SDWebImage

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var imageUrlArray = [String]()
    var postedByArray = [String]()
    var postCommentArray = [String]()
    var likesArray = [Int]()
    var documentIdArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        getDatafromFirestore()
    }
    
    func getDatafromFirestore() {
        
       
        
        let firestoreDatabase = Firestore.firestore()
        
        firestoreDatabase.collection("Posts").order(by: "date", descending: true).addSnapshotListener { querySnapshot, error in
            if error != nil {
                print(error!.localizedDescription)
            } else {
               
                if querySnapshot != nil {
                    
                    self.imageUrlArray.removeAll(keepingCapacity: false)
                    self.postedByArray.removeAll(keepingCapacity: false)
                    self.postCommentArray.removeAll(keepingCapacity: false)
                    self.likesArray.removeAll(keepingCapacity: false)
                    self.documentIdArray.removeAll(keepingCapacity: false)
                    
                    for document in querySnapshot!.documents {
                        if let documentID = document.documentID as? String {
                            self.documentIdArray.append(documentID)
                        }
                        if let postedBy = document.get("postedBy") as? String {
                            self.postedByArray.append(postedBy)
                            print(postedBy)
                        }
                        if let imageUrl = document.get("imageUrl") as? String {
                            self.imageUrlArray.append(imageUrl)
                        }
                        if let likes = document.get("likes") as? Int {
                            self.likesArray.append(likes)
                        }
                        if let comments = document.get("postComment") as? String {
                            self.postCommentArray.append(comments)
                        }
                    }
                    self.tableView.reloadData()
                }
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postedByArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! FeedCellViewController
        cell.userEmailLabel.text = postedByArray[indexPath.row]
        cell.userCommentLabel.text = postCommentArray[indexPath.row]
        cell.userImageView.sd_setImage(with: URL(string: self.imageUrlArray[indexPath.row]))
        cell.userLikeLabel.text = String(likesArray[indexPath.row])
        cell.documentIdLabel.text = documentIdArray[indexPath.row]
        return cell
    }


}

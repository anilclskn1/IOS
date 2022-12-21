//
//  FeedVC.swift
//  SnapchatClone
//
//  Created by AnilyTugce on 7.10.2022.
//

import UIKit
import Firebase
import SDWebImage

let firebaseFirestore = Firestore.firestore();


class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    
    var snapArray = [Snap]()
    var chosenSnap : Snap?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getInfo()
        getSnapsFromFirebase()
    }
    
    func getSnapsFromFirebase() {
        firebaseFirestore.collection("Snaps").order(by: "date", descending: true).addSnapshotListener { snapshot, error in
            if error != nil {
                self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
            }else {
                if snapshot != nil && snapshot?.isEmpty == false {
                    self.snapArray.removeAll(keepingCapacity: false)
                    for document in snapshot!.documents {
                        
                        let docId = document.documentID
                        
                        if let username = document.get("snapOwner") as? String {
                            if let imageUrlArray = document.get("imageUrlArray") as? [String] {
                                if let date = document.get("date") as? Timestamp {
                                    
                                    if let difference = Calendar.current.dateComponents([.hour], from: date.dateValue(), to: Date()).hour {
                                        
                                        if difference >= 24 {
                                            firebaseFirestore.collection("Snaps").document(docId).delete()
                                            
                                        }else {
                                            let snap = Snap(username: username, imageUrlArray: imageUrlArray, date: date.dateValue(), timeLeft: 24 - difference)
                                            self.snapArray.append(snap)
                                        }
                                    }
                                   
                                }
                            }
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }


    func getInfo() {
        firebaseFirestore.collection("UserInfo").whereField("email", isEqualTo: Auth.auth().currentUser!.email!).getDocuments { snaphot, error in
            if error != nil {
                self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
            }else {
                if snaphot != nil && snaphot?.isEmpty == false {
                    for document in snaphot!.documents {
                        if let username = document.get("username") as? String {
                            UserSingleton.sharedUserInfo.email = Auth.auth().currentUser!.email!
                            UserSingleton.sharedUserInfo.username = username
                        }
                    }
                }
            }
        }
        
    }

    func makeAlert(titleInput : String, messageInput : String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return snapArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.feedUsernameLabel.text = snapArray[indexPath.row].username
        cell.feedImageView.sd_setImage(with: URL(string: snapArray[indexPath.row].imageUrlArray[0]))
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSnapVC" {
            let destinationVC = segue.destination as! SnapVC
            
            destinationVC.selectedSnap = chosenSnap
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenSnap = snapArray[indexPath.row]
        performSegue(withIdentifier: "toSnapVC", sender: nil)
    }

}

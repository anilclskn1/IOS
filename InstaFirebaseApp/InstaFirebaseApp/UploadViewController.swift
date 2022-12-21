//
//  UploadViewController.swift
//  InstaFirebaseApp
//
//  Created by AnilyTugce on 20.09.2022.
//

import UIKit
import FirebaseStorage
import Firebase

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        imageView.addGestureRecognizer(gestureRecognizer)
        
    }
    

    @objc func chooseImage() {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
    }
    
    @IBAction func button(_ sender: Any) {
        
        let storage = Storage.storage()
        let storageReference = storage.reference()
        
        let mediaFolder = storageReference.child("media")
        
        let uuid = UUID().uuidString
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5){
            let imageReference = mediaFolder.child("\(uuid).jpg")
            imageReference.putData(data, metadata: nil) { metadata, error in
                if error != nil {
                    self.showAlert(title: "ERROR", message: error?.localizedDescription ?? "Error")
                } else {
                    imageReference.downloadURL { url, error in
                        if error == nil {
                            let url = url?.absoluteString
                            
                            //DATABASE
                            
                            let firestoreDatabase = Firestore.firestore()
                            
                            var firestoreReference : DocumentReference? = nil
                            
                            let firestorePost = ["imageUrl" : url!, "postedBy" : Auth.auth().currentUser!.email!, "postComment" : self.commentTextField.text!, "date" : FieldValue.serverTimestamp(), "likes" : 0] as [String:Any]
                            
                            firestoreReference = firestoreDatabase.collection("Posts").addDocument(data: firestorePost, completion: { error in
                                if error != nil {
                                    self.showAlert(title: "ERROR", message: error?.localizedDescription ?? "ERROR")
                                } else {
                                    self.commentTextField.text = ""
                                    self.imageView.image = UIImage(systemName: "square.and.arrow.up")
                                    // Sends user to feed
                                    self.tabBarController?.selectedIndex = 0
                                }
                            })
                        }
                    }
                }
            }
        }
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let alertButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(alertButton)
        present(alert, animated: true, completion: nil)
    }
    
}

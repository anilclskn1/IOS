//
//  AddpPlaceViewController.swift
//  FourSquareClone
//
//  Created by AnilyTugce on 25.09.2022.
//

import UIKit

class AddpPlaceViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var placeNameTextField: UITextField!
    @IBOutlet weak var placeTypeTextField: UITextField!
    @IBOutlet weak var placeCommentTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
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
        self.present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
    }
   
    @IBAction func nextButtonClicked(_ sender: Any) {
        if placeNameTextField.text != "" && placeTypeTextField.text != "" && placeCommentTextField.text != "" {
            if let chosenImage = imageView.image {
                let addPlaceModel = AddPlaceModel.sharedInstance
                addPlaceModel.placeName = placeNameTextField.text!
                addPlaceModel.placeType = placeTypeTextField.text!
                addPlaceModel.placeComment = placeCommentTextField.text!
                addPlaceModel.placeImage = chosenImage
                
                performSegue(withIdentifier: "toMapVC", sender: nil)
            }
        } else {
            let alert = UIAlertController(title: "Error", message: "Missing info", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
            alert.addAction(okButton)
            present(alert, animated: true, completion: nil)
        }
    }
    
}

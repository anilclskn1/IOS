//
//  DetailsVC.swift
//  artBookApp
//
//  Created by AnilyTugce on 7.09.2022.
//

import UIKit
import CoreData

class DetailsVC: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var artNameTextField: UITextField!
    
    @IBOutlet weak var artistNameTextField: UITextField!
    
    @IBOutlet weak var yearTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    
    var selectedName = ""
    var selectedUUID : UUID?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if selectedName != "" {
            saveButton.isHidden = true
            print("ready to show content")
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
            let idString = selectedUUID?.uuidString
            fetchRequest.predicate = NSPredicate(format: "id = %@", idString!)
            fetchRequest.returnsObjectsAsFaults = false
            
            do {
                let results = try context.fetch(fetchRequest)
                if results.count > 0 {
                    for result in results as! [NSManagedObject] {
                        if let artName = result.value(forKey: "artName") as? String {
                            artNameTextField.text = artName
                        }
                        if let artistName = result.value(forKey: "artistName") as? String {
                            artistNameTextField.text = artistName
                        }
                        if let year = result.value(forKey: "year") as? Int {
                            yearTextField.text = String(year)
                        }
                        if let imageData = result.value(forKey: "art") as? Data {
                            let image = UIImage(data: imageData)
                            imageView.image = image
                        }
                    }
                }
            }catch{
                print("error")
            }
            
            
            
            
        }else {
            saveButton.isHidden = false
            saveButton.isEnabled = false
            print("add button clicked")
        }
        
        //Recognizers
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
        
        imageView.isUserInteractionEnabled = true
        let imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(goToGallery))
        imageView.addGestureRecognizer(imageTapGesture)
        
    }
    
    @objc func goToGallery(){
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        saveButton.isEnabled = true
        self.dismiss(animated: true)
        
    }
    
    @objc func hideKeyboard(){
        view.endEditing(true)
    }

    @IBAction func save(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let content = appDelegate.persistentContainer.viewContext
        
        let newPainting = NSEntityDescription.insertNewObject(forEntityName: "Paintings", into: content)
        
        newPainting.setValue(artNameTextField.text!, forKey: "artName")
        newPainting.setValue(artistNameTextField.text!, forKey: "artistName")
        if let year = Int(yearTextField.text!){
            newPainting.setValue(year, forKey: "year")
        }
        newPainting.setValue(UUID(), forKey: "id")
        
        let data = imageView.image!.jpegData(compressionQuality: 0.5)
        newPainting.setValue(data, forKey: "art")
        
        do{
            try content.save()
            print("success")
        }catch {
            print("error")
        }
        
        
        NotificationCenter.default.post(name: NSNotification.Name("newPost"), object: nil)
        
        self.navigationController?.popViewController(animated: true)
        
    }
    

}

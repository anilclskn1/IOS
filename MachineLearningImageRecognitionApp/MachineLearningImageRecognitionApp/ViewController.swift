//
//  ViewController.swift
//  MachineLearningImageRecognitionApp
//
//  Created by AnilyTugce on 27.09.2022.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    @IBAction func changeButtonClicked(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
        
        //we need ci image type for machine learning processs to use
        
        if let ciImage = CIImage(image: imageView.image!) {
            recognizeImage(image: ciImage)
        }
    }
    
    func recognizeImage(image: CIImage) {
        
        // 1) Request
        // 2) Handler
        
        label.text = "Finding..."
        
        if let model = try? VNCoreMLModel(for: MobileNetV2().model) {
            let request = VNCoreMLRequest(model: model) { vnrequest, error in
                if let results = vnrequest.results as? [VNClassificationObservation] {
                    if results.count > 0 {
                        let topResult = results.first
                        DispatchQueue.main.async {
                            let confidenceLevel = (topResult?.confidence ?? 0) * 100
                            let roundedLevel = Int((confidenceLevel * 100) / 100)
                            self.label.text = "\(roundedLevel)% it is \(topResult!.identifier)"
                        }
                    }
                }
                
               
            }
            
            let handler = VNImageRequestHandler(ciImage: image)
            DispatchQueue.global(qos: .userInteractive).async {
                do {
                    try handler.perform([request])
                } catch {
                    print("error")
                }
            }
        }
        
    }
}


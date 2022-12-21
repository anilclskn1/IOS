//
//  MapViewController.swift
//  FourSquareClone
//
//  Created by AnilyTugce on 25.09.2022.
//

import UIKit
import MapKit
import Parse

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{

    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(AddPlaceModel.sharedInstance.placeName)
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Save", style: UIBarButtonItem.Style.plain, target: self, action: #selector(saveButtonClicked))
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "< Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(backButtonClicked))
        
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(chooseLocation(gestureRecognizer:)))
        gesture.minimumPressDuration = 3
        mapView.addGestureRecognizer(gesture)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // If you do not want to update location all the time use this. Because map may always
        // want to change focus
        locationManager.stopUpdatingLocation()
        let latitude = locations[0].coordinate.latitude
        let longitude = locations[0].coordinate.longitude
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.012, longitudeDelta: 0.012)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    @objc func chooseLocation(gestureRecognizer : UIGestureRecognizer) {
        if gestureRecognizer.state == .began {
            let touchedPoint = gestureRecognizer.location(in: self.mapView)
            let touchedCoordinates = self.mapView.convert(touchedPoint, toCoordinateFrom: self.mapView)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = touchedCoordinates
            annotation.title = AddPlaceModel.sharedInstance.placeName
            annotation.subtitle = AddPlaceModel.sharedInstance.placeType
            self.mapView.addAnnotation(annotation)
            
            AddPlaceModel.sharedInstance.latitude = String(touchedCoordinates.latitude)
            AddPlaceModel.sharedInstance.longitude = String(touchedCoordinates.longitude)
        }
    }
    
    @objc func saveButtonClicked() {
        let object = PFObject(className: "Places")
        object["name"] = AddPlaceModel.sharedInstance.placeName
        object["type"] = AddPlaceModel.sharedInstance.placeType
        object["comment"] = AddPlaceModel.sharedInstance.placeType
        object["latitude"] = AddPlaceModel.sharedInstance.latitude
        object["longitude"] = AddPlaceModel.sharedInstance.longitude
        
        if let imageData = AddPlaceModel.sharedInstance.placeImage.jpegData(compressionQuality: 0.5){
            object["image"] = PFFileObject(name: "image.jpg", data: imageData)
        }
        
        object.saveInBackground { success, error in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            } else {
                self.performSegue(withIdentifier: "fromMapToPlaces", sender: nil)
            }
        }
        
    }

    
    @objc func backButtonClicked() {
        self.dismiss(animated: true)
    }


}

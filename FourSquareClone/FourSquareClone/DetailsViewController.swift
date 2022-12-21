//
//  DetailsViewController.swift
//  FourSquareClone
//
//  Created by AnilyTugce on 25.09.2022.
//

import UIKit
import MapKit
import Parse

class DetailsViewController: UIViewController, MKMapViewDelegate {
    
    var chosenId = ""

    @IBOutlet weak var detailsMapView: MKMapView!
    @IBOutlet weak var detailsPlaceTypeTextField: UILabel!
    @IBOutlet weak var detailsPlaceCommentTextField: UILabel!
    @IBOutlet weak var detailsPlaceNameTextField: UILabel!
    @IBOutlet weak var detailsImageView: UIImageView!
    
    var chosenLatitude = Double()
    var chosenLongitude = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()

  
        detailsMapView.delegate = self
        getDataFromParse()
    }
    
    func getDataFromParse() {
        if chosenId != "" {
            let query = PFQuery(className: "Places")
            query.whereKey("objectId", equalTo: chosenId)
            query.findObjectsInBackground { objects, error in
                if error != nil {
                    self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
                } else {
                    if objects != nil {
                        if objects!.count > 0 {
                            
                            //OBJECTS
                            
                            let chosenPlaceObject = objects![0]
                        
                            if let name = chosenPlaceObject.object(forKey: "name") as? String {
                                self.detailsPlaceNameTextField.text = name
                            }
                            if let type = chosenPlaceObject.object(forKey: "type") as? String {
                                self.detailsPlaceTypeTextField.text = type
                            }
                            if let comment = chosenPlaceObject.object(forKey: "comment") as? String {
                                self.detailsPlaceCommentTextField.text = comment
                            }
                            if let latitude = chosenPlaceObject.object(forKey: "latitude") as? String {
                                if let latitudeDouble = Double(latitude) {
                                    self.chosenLatitude = latitudeDouble
                                }
                            }
                            if let longitude = chosenPlaceObject.object(forKey: "longitude") as? String {
                                if let longitudeDouble = Double(longitude) {
                                    self.chosenLongitude = longitudeDouble
                                }
                            }
                            if let imageData = chosenPlaceObject.object(forKey: "image") as? PFFileObject {
                                imageData.getDataInBackground { data, error in
                                    if error == nil {
                                        if data != nil {
                                            self.detailsImageView.image = UIImage(data: data!)
                                        }
                                    }
                                }
                            }
                            
                            
                            //MAPS
                            
                            let location = CLLocationCoordinate2D(latitude: self.chosenLatitude, longitude: self.chosenLongitude)
                            let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
                            let region = MKCoordinateRegion(center: location, span: span)
                            self.detailsMapView.setRegion(region, animated: true)
                            
                            let annotation = MKPointAnnotation()
                            annotation.coordinate = location
                            annotation.title = self.detailsPlaceNameTextField.text
                            annotation.subtitle = self.detailsPlaceTypeTextField.text
                            self.detailsMapView.addAnnotation(annotation)
                        }
                    }
                }
            }
        }
    }

    func makeAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        let reuseid = "pin"
        var pinview = mapView.dequeueReusableAnnotationView(withIdentifier: reuseid)
        
        if pinview == nil {
            pinview = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseid)
            pinview?.canShowCallout = true
            let button = UIButton(type: .detailDisclosure)
            pinview?.rightCalloutAccessoryView = button
        } else {
            pinview?.annotation = annotation
        }
        return pinview
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if self.chosenLatitude != 0.0 && self.chosenLongitude != 0.0 {
            let requestLocation = CLLocation(latitude: self.chosenLatitude, longitude: self.chosenLongitude)
            
            CLGeocoder().reverseGeocodeLocation(requestLocation) { placemarks, error in
                if let placemark = placemarks {
                    if placemark.count > 0 {
                        let mkPlaceMark = MKPlacemark(placemark: placemark[0])
                        let mapItem = MKMapItem(placemark: mkPlaceMark)
                        mapItem.name = self.detailsPlaceNameTextField.text
                        
                        let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
                        
                        mapItem.openInMaps(launchOptions: launchOptions)
                    }
                }
            }
            
        }
    }

}

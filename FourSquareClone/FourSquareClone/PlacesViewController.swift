//
//  PlacesViewController.swift
//  FourSquareClone
//
//  Created by AnilyTugce on 24.09.2022.
//

import UIKit
import Parse

class PlacesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var nameArray = [String]()
    var idArray = [String]()
    var selectedId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: UIBarButtonItem.Style.plain, target: self, action: #selector(logOutButtonClicked))
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getDataFromParse()
    }
    
    func getDataFromParse() {
        let query = PFQuery(className: "Places")
        query.findObjectsInBackground { objects, error in
            if error != nil {
                self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
            } else {
                if objects != nil {
                    self.nameArray.removeAll(keepingCapacity: false)
                    self.idArray.removeAll(keepingCapacity: false)
                    for object in objects! {
                        if let name = object.object(forKey: "name") as? String {
                            if let id = object.objectId {
                                self.nameArray.append(name)
                                self.idArray.append(id)
                            }
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = nameArray[indexPath.row]
        cell.contentConfiguration = content
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC" {
            let destinationVC = segue.destination as? DetailsViewController
            destinationVC?.chosenId = selectedId
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedId = idArray[indexPath.row]
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    @objc func addButtonClicked() {
        performSegue(withIdentifier: "toAddPlaceVC", sender: nil)
    }
  
    @objc func logOutButtonClicked() {
        PFUser.logOutInBackground { error in
            if error != nil {
                self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
            }
            else {
                self.performSegue(withIdentifier: "toSignUpVC", sender: nil)
            }
        }
    }
    
    func makeAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }

}

//
//  ViewController.swift
//  LandmarkBookApp
//
//  Created by AnilyTugce on 2.09.2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var elementNames = [String]()
    var elementImages = [UIImage]()
    
    var chosenImage = UIImage()
    var chosenName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        elementNames.append("colosseum")
        elementNames.append("galata")
        elementNames.append("greatwall")
        elementNames.append("kremlin")
        elementNames.append("stonhenge")
        elementNames.append("tajmahal")
        
        elementImages.append(UIImage(named: "colosseum")!)
        elementImages.append(UIImage(named: "galata")!)
        elementImages.append(UIImage(named: "greatwall")!)
        elementImages.append(UIImage(named: "kremlin")!)
        elementImages.append(UIImage(named: "stonhenge")!)
        elementImages.append(UIImage(named: "tajmahal")!)
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elementNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = elementNames[indexPath.row]
        cell.contentConfiguration = content
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenName = elementNames[indexPath.row]
        chosenImage = elementImages[indexPath.row]
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC" {
            let destinationVC = segue.destination as! DetailsVC
            destinationVC.name = chosenName
            destinationVC.image = chosenImage
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        elementNames.remove(at: indexPath.row)
        elementImages.remove(at: indexPath.row)
        //tableView.reloadData()
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
}


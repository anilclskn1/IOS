//
//  ViewController.swift
//  SimpsonApp
//
//  Created by AnilyTugce on 4.09.2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var mySimpsons = [Simpsons]()
    var chosenSimpson : Simpsons?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        let bart = Simpsons(nameInit: "Bart Simpson", jobInit: "Kid", imageInit: UIImage(named: "bart")!)
        let homer = Simpsons(nameInit: "Homer Simpson", jobInit: "Dad", imageInit: UIImage(named: "homer")!)
        let lisa = Simpsons(nameInit: "Lisa Simpson", jobInit: "Mom", imageInit: UIImage(named: "lisa")!)
        let marge = Simpsons(nameInit: "Marge Simpson", jobInit: "Sister", imageInit: UIImage(named: "marge")!)
        
        mySimpsons.append(bart)
        mySimpsons.append(homer)
        mySimpsons.append(lisa)
        mySimpsons.append(marge)

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mySimpsons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = mySimpsons[indexPath.row].name
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenSimpson = mySimpsons[indexPath.row]
        self.performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC" {
            let destination = segue.destination as? detailsController
            destination?.selectedSimpson = chosenSimpson
        }
    }


}


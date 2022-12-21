//
//  ListViewController.swift
//  mapApp
//
//  Created by AnilyTugce on 9.09.2022.
//

import UIKit
import CoreData

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var nameArray = [String]()
    var idArray = [UUID]()
    
    var chosenTitle = ""
    var chosenId : UUID?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addLocation))
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getData()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name("newPlace"), object: nil)
    }
    
   @objc func getData() {
        nameArray.removeAll(keepingCapacity: false)
        idArray.removeAll(keepingCapacity: false)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Places")
        fetchRequest.returnsObjectsAsFaults = false
        
        do{
            let results = try context.fetch(fetchRequest)
            
            if results.count > 0 {
                for result in results as! [NSManagedObject]{
                    
                    if let title = result.value(forKey: "title") as? String {
                        nameArray.append(title)
                    }
                    
                    if let id = result.value(forKey: "id") as? UUID {
                        idArray.append(id)
                    }
                    
                }
                
                tableView.reloadData()
            }

        }catch{
            print("error")
        }
    }
    
    @objc func addLocation() {
        chosenTitle = ""
        performSegue(withIdentifier: "toViewController", sender: nil)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenTitle = nameArray[indexPath.row]
        chosenId = idArray[indexPath.row]
        performSegue(withIdentifier: "toViewController", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toViewController" {
            let destinationVC  = segue.destination as! ViewController
            destinationVC.selectedTitle = chosenTitle
            destinationVC.selectedId = chosenId
        }
    }



}

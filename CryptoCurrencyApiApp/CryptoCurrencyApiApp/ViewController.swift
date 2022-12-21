//
//  ViewController.swift
//  CryptoCurrencyApiApp
//
//  Created by AnilyTugce on 20.09.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var btcLabel: UILabel!
    @IBOutlet weak var rvnLabel: UILabel!
    @IBOutlet weak var reefLabel: UILabel!
    @IBOutlet weak var ethLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
  
 
    }

    @IBAction func startButton(_ sender: Any) {
        // 1) Request & Session
        // 2) Respose & Data
        // 3) Parsing & JSON Serialization
        
        
        // 1)
        let url = URL(string: "http://api.coinlayer.com/api/live?access_key=12ef056e0eeb4bde0e0aa2e6abc08968")

        let session = URLSession.shared
        
        //Closure
        let task = session.dataTask(with: url!) { data, response, error in
            
            if error != nil {
                
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                
                let alertButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                
                alert.addAction(alertButton)
                
                self.present(alert, animated: true, completion: nil)
                
            } else {
                
                if data != nil {
                    // 2)
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                        
                        // ASYNC
                        DispatchQueue.main.async {
                            if let rates = jsonResponse["rates"] as? [String : Any] {
                                
                                if let btc = rates["BTC"] as? Double {
                                    self.btcLabel.text = "BTC : \(btc)"
                                }
                                if let eth = rates["ETH"] as? Double {
                                    self.ethLabel.text = "ETH : \(eth)"
                                }
                                if let waves = rates["WAVES"] as? Double {
                                    self.reefLabel.text = "WAVES : \(waves)"
                                }
                                if let rvn = rates["RVN"] as? Double {
                                    self.rvnLabel.text = "RVN : \(rvn)"
                                }
                                
                            }
                        }
                    }
                    catch {
                        print("error")
                    }
                }
            }
        }
        // This is needed to start task
        task.resume()
        
    }
    
}


//
//  ViewController.swift
//  CryptoCrazy
//
//  Created by AnilyTugce on 8.10.2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    private var cryptoListvViewModel : CryptoListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        getData()
    }
    
    func getData() {
        let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!
        Webservice().downloadCurrencies(url: url) { cryptos in
            if cryptos != nil {
                print(cryptos!)
                self.cryptoListvViewModel = CryptoListViewModel(cryptoCurrencyList: cryptos!)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cryptoListvViewModel == nil ? 0 : self.cryptoListvViewModel.cryptoCurrencyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CryptoCell", for: indexPath) as! CryptoTableViewCell
        let cryptoViewModel = self.cryptoListvViewModel.cryptoAtIndex(index: indexPath.row)
        cell.currencyText.text = cryptoViewModel.name
        cell.priceText.text = cryptoViewModel.price
        return cell
    }


}


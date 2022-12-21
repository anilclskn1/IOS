//
//  Websevice.swift
//  CryptoCrazy
//
//  Created by AnilyTugce on 8.10.2022.
//

import Foundation

class Webservice {
    
    func downloadCurrencies(url : URL, completion : @escaping ([CryptoCurrency]?) -> ()){
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                print(error?.localizedDescription ?? "Error")
                // If there is error give competion nil directly
                completion(nil)
            }else {
                if let data = data {
                    
                    // This makes all job
                    let cryptoList = try? JSONDecoder().decode([CryptoCurrency].self, from: data)
                    
                    if let cryptoList = cryptoList {
                        completion(cryptoList)
                        print(cryptoList)
                    }
                }
                
            }
        }.resume()
    }
}

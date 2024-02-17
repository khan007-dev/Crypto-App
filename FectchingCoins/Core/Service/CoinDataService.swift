//
//  CoinDataService.swift
//  FectchingCoins
//
//  Created by Khan on 17.02.2024.
//

import Foundation
class CoinDataService {
    
    func fetchPrice(coin: String, completion: @escaping (Double) -> Void) {
        
        let urlString = "https://api.coingecko.com/api/v3/simple/price?ids=\(coin)&vs_currencies=usd"
        
        guard let url = URL(string: urlString) else { return}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            DispatchQueue.main.async {
                
                
                // implement serivce class ->
                
                if let error = error {
                    print("DEBUG: Failed with Error \(error.localizedDescription)")
                    //   self.errorMessage = error.localizedDescription
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    //    self.errorMessage = "Bad HTTP Response"
                    return
                }
                
                guard httpResponse.statusCode == 200  else {
                    //   self.errorMessage = "failed to fetch with status code \(httpResponse.statusCode)"
                    return
                }
                
                guard let data = data else {return}
                guard let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {return}
                
                guard let value = jsonObject[coin] as? [String: Int] else {return}
                guard let price = value["usd"] else {return}
                
                
                
                
                print("Price is \(price)")
                completion(Double(price))
                
            }
        }.resume()
      
        
    }
}

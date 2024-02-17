//
//  CoinDataService.swift
//  FectchingCoins
//
//  Created by Khan on 17.02.2024.
//

import Foundation
class CoinDataService {
    let urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=chf&order=market_cap_desc&per_page=20&page=1&sparkline=false&price_change_percentage=24h&locale=en"
    func fetchCoins(completion: @escaping([Coin]) -> Void) {
      
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) { data, response, error  in
            
            guard let data = data else {return}
            
        
            guard  let coins = try? JSONDecoder().decode([Coin].self, from: data) else {
            
                print("DEBUG: Failed to Decode coins")
                return}
        
            completion(coins)
            
        }.resume()
    }
    
  
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

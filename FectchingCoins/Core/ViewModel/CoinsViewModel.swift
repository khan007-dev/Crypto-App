//
//  CoinsViewModel.swift
//  FectchingCoins
//
//  Created by Khan on 14.02.2024.
//

import Foundation

class CoinsViewModel: ObservableObject {
    
    @Published var coins = ""
    @Published var price = ""
    @Published var errorMessage: String?
    
    init() {
        fetchPrice(coin: "bitcoin")
    }
    
    func fetchPrice(coin: String) {
  
        let urlString = "https://api.coingecko.com/api/v3/simple/price?ids=\(coin)&vs_currencies=usd"
        
        guard let url = URL(string: urlString) else { return}
        
        URLSession.shared.dataTask(with: url) { data, response, error in

            // implement serivce class ->
            
            if let error = error {
                print("DEBUG: Failed with Error \(error.localizedDescription)")
                self.errorMessage = error.localizedDescription
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                self.errorMessage = "Bad HTTP Response"
                return
            }
            
            guard httpResponse.statusCode == 200  else {
                self.errorMessage = "failed to fetch with status code \(httpResponse.statusCode)"
                return
            }
            
            guard let myData = data else {return}
            guard let jsonObject = try? JSONSerialization.jsonObject(with: myData) as? [String: Any] else {return}
            
            guard let value = jsonObject[coin] as? [String: Int] else {return}
            guard let price = value["usd"] else {return}
            
            DispatchQueue.main.async {
                self.coins = coin.capitalized
                self.price = "$\(price)"
            }
            

            
        }.resume()
        
        print("After ULR Session")
   
    }
}

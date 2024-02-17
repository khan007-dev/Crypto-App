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
    private let service = CoinDataService()
    init() {
       fetchPrice(coin: "bitcoin")
    }
    
    func fetchPrice(coin: String) {
        
        service.fetchPrice(coin: coin) { priceFromService in
            DispatchQueue.main.async {
                
                  self.price = "\(priceFromService)"
                  self.coins = coin
            }
        }
    }
    
  
}

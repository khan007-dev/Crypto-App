//
//  CoinsViewModel.swift
//  FectchingCoins
//
//  Created by Khan on 14.02.2024.
//

import Foundation

class CoinsViewModel: ObservableObject {
    
    @Published var coins = [Coin]()
    
    private let service = CoinDataService()
    init() {
        fetchCoins()
    }
    func fetchCoins() {
        service.fetchCoins { coins in
            
            DispatchQueue.main.sync {
                
                self.coins = coins
            }
        }
    }
    
    
  
}

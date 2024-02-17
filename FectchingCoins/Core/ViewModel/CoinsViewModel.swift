//
//  CoinsViewModel.swift
//  FectchingCoins
//
//  Created by Khan on 14.02.2024.
//

import Foundation

class CoinsViewModel: ObservableObject {
    
    @Published var coins = [Coin]()
    @Published var errorMessage: String?
    private let service = CoinDataService()
    init() {
        fetchCoins()
    }
    func fetchCoins() {
//        service.fetchCoins { coins, error in
//            
//            DispatchQueue.main.sync {
//                
//                if let error = error {
//                    self.errorMessage = error.localizedDescription
//                    return
//                }
//                
//                self.coins = coins ?? []
//            }
//        }
        
        service.fetchCoinsWithResult { result in
          
            DispatchQueue.main.sync {
                switch result {
                case .success(let coins):
                    self.coins = coins
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
        
        
    }
    
    
  
}

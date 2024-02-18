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
    
        Task {
           try await fetchCoins()
        }
    }
    
    func fetchCoins() async throws {
        self.coins = try await service.fetchCoins()
    
    }
    
    func fetchCoinsWithCompletionHandler() {

        service.fetchCoinsWithResult { [weak self ]result in
          
            DispatchQueue.main.sync {
                switch result {
                case .success(let coins):
                    self?.coins = coins
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
        
        
    }
    
    
  
}

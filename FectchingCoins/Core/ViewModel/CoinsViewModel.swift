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
            await fetchCoins()
        }
    }
    
    @MainActor
    func fetchCoins() async  {
  
        do {
            self.coins = try await service.fetchCoins()
        } catch {
            
            guard let error = error as? CoinApiError else { return}
            self.errorMessage = error.customDescription
        }
    
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

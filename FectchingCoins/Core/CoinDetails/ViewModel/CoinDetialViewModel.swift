//
//  CoinDetialViewModel.swift
//  FectchingCoins
//
//  Created by Khan on 19.02.2024.
//

import Foundation

class CoinDetialViewModel: ObservableObject {
    private let service = CoinDataService()
    private let coinId: String
    
    @Published var coinDetials: CoinDetial?
    init(coinId: String) {
        self.coinId = coinId
    
//        Task {
//            await fetchCoinDetials()
//        }
    }
    
    @MainActor
    func fetchCoinDetials() async  {
      
        do
        {
            self.coinDetials = try await service.fetchCoinDetials(id: coinId)
        }
        catch {
        
            print("DEBUG: Error \(error.localizedDescription)")
        }
    }
}

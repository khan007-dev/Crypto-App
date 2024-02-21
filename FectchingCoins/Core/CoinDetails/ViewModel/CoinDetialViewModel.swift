//
//  CoinDetialViewModel.swift
//  FectchingCoins
//
//  Created by Khan on 19.02.2024.
//

import Foundation

class CoinDetialViewModel: ObservableObject {
    private let service: CoinServiceProtocol
    private let coinId: String
    
    @Published var coinDetials: CoinDetial?
    init(coinId: String, service: CoinServiceProtocol) {
        self.service = service
        self.coinId = coinId

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

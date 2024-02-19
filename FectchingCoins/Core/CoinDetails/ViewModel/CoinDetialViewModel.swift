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
    
    init(coinId: String) {
        self.coinId = coinId
    
        Task {
            await fetchCoinDetials()
        }
    }
    
    func fetchCoinDetials() async {
        do
        {
            let detials = try await service.fetchCoinDetials(id: coinId)
            print("DEBUG: Detials \(detials)")
        }
        catch {
        
            print("DEBUG: Error \(error.localizedDescription)")
        }
    }
}

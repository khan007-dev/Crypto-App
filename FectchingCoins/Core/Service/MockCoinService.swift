//
//  MockCoinService.swift
//  FectchingCoins
//
//  Created by Khan on 21.02.2024.
//

import Foundation
class MockCoinService: CoinServiceProtocol {
    func fetchCoins() async throws -> [Coin] {
        
        let bitcoin = Coin(id: "bitcoin", symbol: "btc", name: "Bitcoin", currentPrice: 25000, marketCapRank: 1)
        return [bitcoin]
    }
    
    func fetchCoinDetials(id: String) async throws -> CoinDetial? {
        let description = Description(text: "Test Description")
        let bitcoinDetials = CoinDetial(id: "bitcoin", symbol: "btc", name: "Bitcoin", description:description)
        return bitcoinDetials
    }
    
    
}

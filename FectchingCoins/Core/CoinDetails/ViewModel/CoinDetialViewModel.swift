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
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        print("DEBUG: Task wake up")
        do
        {
            let detials = try await service.fetchCoinDetials(id: coinId)
            print("DEBUG: Detials \(detials)")
            self.coinDetials = detials
        }
        catch {
        
            print("DEBUG: Error \(error.localizedDescription)")
        }
    }
}

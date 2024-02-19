//
//  CoinDetialsView.swift
//  FectchingCoins
//
//  Created by Khan on 19.02.2024.
//

import SwiftUI

struct CoinDetialsView: View {
    
    let coin: Coin
    @ObservedObject var viewModel: CoinDetialViewModel
    init(coin: Coin) {
        self.coin = coin
        self.viewModel = CoinDetialViewModel(coinId: coin.id)
    }
    var body: some View {
     
        VStack {
            Text(coin.name)
        }
    }
}

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
            if let detials = viewModel.coinDetials {
                Text(detials.name)
                    .fontWeight(.semibold)
                    .font(.subheadline)
                
                Text(detials.symbol.uppercased())
                    .font(.footnote)
            
                Text(detials.description.text)
                .font(.footnote)
                .padding(.vertical)
         
            }
        
        }.task {
             await viewModel.fetchCoinDetials()
        }
        .padding()
       
      
    }
}

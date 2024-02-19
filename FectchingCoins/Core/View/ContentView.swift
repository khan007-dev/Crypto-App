//
//  ContentView.swift
//  FectchingCoins
//
//  Created by Khan on 13.02.2024.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = CoinsViewModel()
    var body: some View {
       
        NavigationStack {
            List {
                ForEach(viewModel.coins) { coin in
                    NavigationLink(value: coin) {
                        HStack (spacing: 12) {
                            Text("\(coin.marketCapRank)")
                                .foregroundStyle(.gray)
                            VStack (alignment: .leading) {
                                
                                Text(coin.name.uppercased())
                                    .fontWeight(.semibold)
                                Text(coin.symbol)
                            }
                        }.font(.footnote)
                    }
                }
            }
            .navigationDestination(for: Coin.self, destination: { coin in
                CoinDetialsView(coin: coin)            })
            .overlay {
                if let error = viewModel.errorMessage {
                    Text(error)
                }
            }
        }
       
    }
}

#Preview {
    ContentView()
}

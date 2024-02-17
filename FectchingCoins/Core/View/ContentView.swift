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
       
        List {
            ForEach(viewModel.coins) { coin in
                HStack {
                    Text("\(coin.marketCapRank)")
                        .foregroundStyle(.gray)
                    VStack (alignment: .leading) {
                        
                        Text(coin.name)
                            .fontWeight(.semibold)
                        Text(coin.symbol)
                    }
                }
            }
        }
        .overlay {
            if let error = viewModel.errorMessage {
                Text(error)
            }
        }
    }
}

#Preview {
    ContentView()
}

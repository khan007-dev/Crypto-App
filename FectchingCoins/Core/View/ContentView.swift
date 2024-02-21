//
//  ContentView.swift
//  FectchingCoins
//
//  Created by Khan on 13.02.2024.
//

import SwiftUI

struct ContentView: View {
    private let service: CoinServiceProtocol
    @StateObject var viewModel: CoinsViewModel
    
    init(service: CoinServiceProtocol) {
        self.service = service
        self._viewModel = StateObject(wrappedValue: CoinsViewModel(service: service))
    }
    
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
                CoinDetialsView(coin: coin, service: service)            })
            .overlay {
                if let error = viewModel.errorMessage {
                    Text(error)
                }
            }
        }
       
    }
}

#Preview {
    ContentView(service: CoinDataService())
}

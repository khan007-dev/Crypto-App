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
                Text(coin.name)
            }
        }
    }
}

#Preview {
    ContentView()
}

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
        VStack {
            
            if let errorMessage = viewModel.errorMessage {
               Text(errorMessage)
            } else { 
                
                Text(" \(viewModel.coins) \(viewModel.price)")
            }
        
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

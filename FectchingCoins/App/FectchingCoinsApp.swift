//
//  FectchingCoinsApp.swift
//  FectchingCoins
//
//  Created by Khan on 13.02.2024.
//

import SwiftUI

@main
struct FectchingCoinsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(service: CoinDataService())
        }
    }
}

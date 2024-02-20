//
//  CoinDetialModel.swift
//  FectchingCoins
//
//  Created by Khan on 19.02.2024.
//

import Foundation

struct CoinDetial: Codable {
    let id: String
    let symbol: String
    let name: String
    let description: Description
}

struct Description: Codable {
    let text: String
    
    enum CodingKeys: String, CodingKey {
        case text = "en"
        
    }
}

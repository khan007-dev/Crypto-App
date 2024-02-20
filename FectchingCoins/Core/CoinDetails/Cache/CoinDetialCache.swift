//
//  CoinDetialCahce.swift
//  FectchingCoins
//
//  Created by Khan on 20.02.2024.
//

import Foundation
class CoinDetialCache {
    
    static let shared = CoinDetialCache()
    
    private let cache = NSCache<NSString, NSData>()
    
    private init() {
        
    }
    func set(_ coinDetials: CoinDetial, forKey key: String) {
     
        guard let data = try? JSONEncoder().encode(coinDetials) else { return}
        cache.setObject(data as NSData, forKey: key as NSString)
    }
    func get(forKey key: String) -> CoinDetial? {
        guard let data = cache.object(forKey: key as NSString) as Data? else { return nil }
        return try? JSONDecoder().decode(CoinDetial.self, from: data)
    }
}

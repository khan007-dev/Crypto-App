//
//  HTTPDataDownloader.swift
//  FectchingCoins
//
//  Created by Khan on 20.02.2024.
//

import Foundation
protocol HTTPDataDownloader {
    func fetchData <T: Decodable> (as type: T.Type, endpoint: String) async throws -> T
}

extension HTTPDataDownloader {
    
    
    func fetchData <T: Decodable> (as type: T.Type, endpoint: String) async throws -> T{
        
        guard let url = URL(string: endpoint) else {
            
            throw CoinApiError.requestFailed(description: "Invalid URL")
            
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw CoinApiError.requestFailed(description: "Request Failed")
            
        }
        
        guard httpResponse.statusCode == 200  else {
            
            throw CoinApiError.invalidStatusCode(statusCode: httpResponse.statusCode)
            
        }
        
        do {
            return try JSONDecoder().decode(type, from: data)
        }
        
        catch {
            
            print("DEBUG: \(error)")
            throw error as? CoinApiError ?? .unknownError(error: error)
        }
    }
}

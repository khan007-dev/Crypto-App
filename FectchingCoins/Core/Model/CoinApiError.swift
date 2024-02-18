//
//  CoinApiError.swift
//  FectchingCoins
//
//  Created by Khan on 18.02.2024.
//

import Foundation

enum CoinApiError: Error {
    
    case invalidData
    case jsonParsingFailure
    case requestFailed(description: String)
    case invalidStatusCode(statusCode: Int)
    case unknownError(error: Error)
    
    var customDescription: String {
        
        switch self {
        case .invalidData: return "Invalid data"
        case .jsonParsingFailure: return "Failed to parse JSON"
        case let .requestFailed(description) : return "Request Failed: \(description)"
        case let .invalidStatusCode(statusCode): return "Invalid Status Code: \(statusCode)"
        case let .unknownError(error): return "An Unknown error Occured \(error.localizedDescription)"
        }
    }
}

//
//  CoinDataService.swift
//  FectchingCoins
//
//  Created by Khan on 17.02.2024.
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

class CoinDataService: HTTPDataDownloader {
    let urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=chf&order=market_cap_desc&per_page=20&page=1&sparkline=false&price_change_percentage=24h&locale=en"
    
    
    
    func fetchCoins()  async throws -> [Coin] {
        return try await fetchData(as: [Coin].self, endpoint: urlString)
        
    }
    
    func fetchCoinDetials(id: String) async throws -> CoinDetial? {
        
        let detialsUrlString = "https://api.coingecko.com/api/v3/coins/\(id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false"
        
        return try await fetchData(as: CoinDetial.self, endpoint: detialsUrlString)
        
        
    }
    
    
}


// MARK: Completion Handlers
extension CoinDataService {
    func fetchCoinsWithResult(completion: @escaping(Result<[Coin], CoinApiError>) -> Void) {
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) { data, response, error  in
            
            if let error = error {
                completion(.failure(.unknownError(error: error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.requestFailed(description: "Request Failed")))
                return
            }
            
            guard httpResponse.statusCode == 200  else {
                
                completion(.failure(.invalidStatusCode(statusCode: httpResponse.statusCode)))
                return
            }
            
            guard let data = data else {
                
                completion(.failure(.invalidData))
                return}
            
            do {
                let coins = try JSONDecoder().decode([Coin].self, from: data)
                completion(.success(coins))
            }
            catch {
                print("DEBUG: Failed to decode with error \(error)")
                completion(.failure(.jsonParsingFailure))
            }
            
            
        }.resume()
    }
    
    
    func fetchPrice(coin: String, completion: @escaping (Double) -> Void) {
        
        let urlString = "https://api.coingecko.com/api/v3/simple/price?ids=\(coin)&vs_currencies=usd"
        
        guard let url = URL(string: urlString) else { return}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            DispatchQueue.main.async {
                
                if let error = error {
                    print("DEBUG: Failed with Error \(error.localizedDescription)")
                    //   self.errorMessage = error.localizedDescription
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    //    self.errorMessage = "Bad HTTP Response"
                    return
                }
                
                guard httpResponse.statusCode == 200  else {
                    //   self.errorMessage = "failed to fetch with status code \(httpResponse.statusCode)"
                    return
                }
                
                guard let data = data else {return}
                guard let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {return}
                
                guard let value = jsonObject[coin] as? [String: Int] else {return}
                guard let price = value["usd"] else {return}
                
                print("Price is \(price)")
                completion(Double(price))
                
            }
        }.resume()
        
        
    }
}

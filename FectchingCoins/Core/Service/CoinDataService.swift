//
//  CoinDataService.swift
//  FectchingCoins
//
//  Created by Khan on 17.02.2024.
//

import Foundation

class CoinDataService: HTTPDataDownloader {
    
    func fetchCoins()  async throws -> [Coin] {
        guard let endpoint = allCoinsURLString else {
            throw CoinApiError.requestFailed(description: "Invalid Endpoint")
        }
        return try await fetchData(as: [Coin].self, endpoint: endpoint)
        
       }
    
    private func coinDetialsURLString(id: String) -> String? {
        var components = baseUrlComponents
        components.path += "\(id)"
        
        components.queryItems = [
            .init(name: "localization", value: "false")
        ]
        return components.url?.absoluteString
      }
    
    func fetchCoinDetials(id: String) async throws -> CoinDetial? {
        
        guard let endPoint = coinDetialsURLString(id: id) else
        {
            throw CoinApiError.requestFailed(description: "Invalid EndPoint")
        }
        
        return try await fetchData(as: CoinDetial.self, endpoint: endPoint)
        
      }
    
    
    private var baseUrlComponents: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.coingecko.com"
        components.path = "/api/v3/coins/"
        return components
     }
    
    private var allCoinsURLString: String? {
        var components = baseUrlComponents
        components.path += "markets"
        
        components.queryItems = [
        
            .init(name: "vs_currency", value: "chf"),
            .init(name: "order", value: "market_cap_desc"),
            .init(name: "per_page", value: "20"),
            .init(name: "page", value: "1"),
            .init(name: "price_change_percentage", value: "24h")
        ]
        
        return components.url?.absoluteString
        
    }

}

// MARK: Completion Handlers
extension CoinDataService {
    func fetchCoinsWithResult(completion: @escaping(Result<[Coin], CoinApiError>) -> Void) {
        guard let url = URL(string: allCoinsURLString ?? "") else {return}
        
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

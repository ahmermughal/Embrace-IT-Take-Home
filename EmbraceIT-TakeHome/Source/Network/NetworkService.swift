//
//  NetworkService.swift
//  EmbraceIT-TakeHome
//
//  Created by Ahmer Mughal on 9/2/22.
//

import Foundation

class NetworkService : NetworkServiceProtocol{
    
    // MARK: Variables
    static let shared = NetworkService()
    private var urlSession : URLSession
    
    // MARK: Init
    init(urlSession: URLSession = .shared){
        self.urlSession = urlSession
    }
 
    // MARK: Network Functions
    func getAPI<T:Decodable>(url : String, params: [String : String] = [:], resultType: T.Type, completed: @escaping (Result<T, NetworkError>) -> Void){
        
        guard var urlComponent = URLComponents(string: url) else {
            
            completed(.failure(.invalidURL))
            return
        }
        
        var queryItems : [URLQueryItem] = []
        let apiKeyItem = URLQueryItem(name: "key", value: Constants.Network.API_KEY)
        queryItems.append(apiKeyItem)
        
        for item in params{
            queryItems.append(URLQueryItem(name: item.key, value: item.value))
        }
        
        urlComponent.queryItems = queryItems

        guard let url = urlComponent.url else{
            completed(.failure(.invalidURL))
            return
        }
        
        let dataTask = urlSession.dataTask(with: url) { data, response, error in
            
            guard let response = response as? HTTPURLResponse, (200 ..< 300).contains(response.statusCode) else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else{
                completed(.failure(.invalidData))
                return
            }

            do{
                let decoder = JSONDecoder()
                let response = try decoder.decode(T.self, from: data)
                completed(.success(response))
            }catch{
                completed(.failure(.invalidData))
            }
            
        }
        
        dataTask.resume()
    }
    
    
}

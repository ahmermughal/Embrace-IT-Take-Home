//
//  APIs.swift
//  EmbraceIT-TakeHome
//
//  Created by Ahmer Mughal on 9/2/22.
//

import Foundation

struct APIs : APIsProtocol{
    
    static func getLastThirtyDaysWeather(of city: String, completed : @escaping (Result<WeatherResponse, NetworkError>) -> Void){
                
        let urlStr = Constants.Network.BASE_URL + "/\(city)/"

        let params = ["include" : "days", "elements" : "temp,windspeed", "unitGroup" : "metric"]
        
        NetworkService.shared.getAPI(url: urlStr, params: params, resultType: WeatherResponse.self) { result in
            
            switch result{
            case .success(let response):
                completed(.success(response))
                break
            case .failure(let error):
                completed(.failure(error))
                break
            }
        }
    }
    
}

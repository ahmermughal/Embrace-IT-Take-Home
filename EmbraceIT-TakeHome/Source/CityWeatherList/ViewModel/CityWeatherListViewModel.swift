//
//  CityWeatherListViewModel.swift
//  EmbraceIT-TakeHome
//
//  Created by Ahmer Mughal on 9/2/22.
//

import Foundation

struct CityWeatherListViewModel{
    
    func getWeather(){
        
        APIs.getWeather(of: "Islamabad,Pakistan", from: "2022-08-01", to: "2022-09-01") { result in
            
            switch result{
                
            case .success(let response):
                print(response)
                break
            case .failure(let error):
                print(error)
                break
            }
            
        }
        
        
    }
    
}

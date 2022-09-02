//
//  CityWeatherListViewModel.swift
//  EmbraceIT-TakeHome
//
//  Created by Ahmer Mughal on 9/2/22.
//

import Foundation

struct CityWeatherListViewModel{
    
    
    private let cities = ["Copenhagen,Denmark", "Lodz,Poland", "Brussels,Belgium", "Islamabad,Pakistan"]
    
    
    func getWeatherData(){
        
        let dispatchGroup = DispatchGroup()
        
        
        for city in cities {
            dispatchGroup.enter()
            getCityWeather(of: city, from: "2022-08-01", to: "2022-08-01") { response, status in
                dispatchGroup.leave()
                if !status {
                    dispatchGroup.suspend()
                    return
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            // whatever you want to do when both are done
        }

        
        
    }
    
    private func getCityWeather(of city: String, from: String, to: String, completed : @escaping ((WeatherResponse?, Bool) -> Void )){
        
        APIs.getWeather(of: city, from: from, to: to) { result in
            
            switch result{
                
            case .success(let response):
                print(response)
                completed(response, true)
                break
            case .failure(let error):
                completed(nil, false)
                print(error)
                break
            }
            
        }
        
        
    }
    
}

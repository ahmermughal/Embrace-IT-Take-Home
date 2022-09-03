//
//  CityWeatherListViewModel.swift
//  EmbraceIT-TakeHome
//
//  Created by Ahmer Mughal on 9/2/22.
//

import Foundation

protocol CityWeatherListViewModelDelegate{
    
    func responseCompleted(tempByCities: [TempByCity])
    func errorOccured()
}

struct CityWeatherListViewModel{
    
    var delegate : CityWeatherListViewModelDelegate?
    
    
    private let cities = ["Copenhagen, Denmark", "Lodz, Poland", "Brussels,Belgium", "Islamabad, Pakistan", "Current Location"]
    
    func getWeatherData(latlong: String){
        
        var tempByCities : [TempByCity] = []

        let dispatchGroup = DispatchGroup()
        
        
        for city in cities {
            dispatchGroup.enter()
            let location = city == "Current Location" ? latlong : city
            getCityWeather(of: location) { response, status in
                guard let safeResponse = response, status else {
                    dispatchGroup.suspend()
                    delegate?.errorOccured()
                    return
                }
                dispatchGroup.leave()
                tempByCities.append(TempByCity(city: safeResponse.city, avgTemp: safeResponse.avgTemp, avgWindSpeed: safeResponse.avgWindSpeed))

            }
        }

        dispatchGroup.notify(queue: .main) {
            delegate?.responseCompleted(tempByCities: tempByCities)
        }

    }
    
    private func getCityWeather(of city: String, completed : @escaping ((WeatherResponse?, Bool) -> Void )){
        
        APIs.getLastThirtyDaysWeather(of: city) { result in
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

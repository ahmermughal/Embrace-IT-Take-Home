//
//  CityWeatherListViewModel.swift
//  EmbraceIT-TakeHome
//
//  Created by Ahmer Mughal on 9/2/22.
//

import Foundation

protocol CityWeatherListViewModelDelegate{
    
    func responseCompleted(tempByCities: [TempByCity])
    func errorOccured(error: Error)
}

struct CityWeatherListViewModel{
    
    var delegate : CityWeatherListViewModelDelegate?
    
    
    private let cities = ["Copenhagen,Denmark", "Lodz,Poland", "Brussels,Belgium", "Islamabad,Pakistan", "Current Location"]
    
    func getWeatherData(latlong: String = ""){
        
        var tempByCities : [TempByCity] = []

        let dispatchGroup = DispatchGroup()
        
        
        for city in cities {
            
            // when latlong is empty then dont query for current location
            if latlong == "" && city == "Current Location" {
                continue
            }
            
            dispatchGroup.enter()
            let location = city == "Current Location" ? latlong : city
            getCityWeather(of: location) { response, status, error in
                dispatchGroup.leave()
                guard let safeResponse = response, status else {
                    dispatchGroup.suspend()
                    delegate?.errorOccured(error: error!)
                    return
                }
                
                // Check to replace Latitude and Logitude with Current Location
                var cityStr = safeResponse.city
                let decimalCharacters = CharacterSet.decimalDigits

                let decimalRange = cityStr.rangeOfCharacter(from: decimalCharacters)

                if decimalRange != nil {
                    cityStr = "Current Location"
                }
                                
                tempByCities.append(TempByCity(city: cityStr, avgTemp: safeResponse.avgTemp, avgWindSpeed: safeResponse.avgWindSpeed, medianTemp: safeResponse.medianTemp, medianSpeed: safeResponse.medianWindSpeed))

            }
        }

        dispatchGroup.notify(queue: .main) {
            delegate?.responseCompleted(tempByCities: tempByCities)
        }

    }
    
    private func getCityWeather(of city: String, completed : @escaping ((WeatherResponse?, Bool, Error?) -> Void )){
        
        APIs.getLastThirtyDaysWeather(of: city) { result in
            switch result{
                
            case .success(let response):
                //print(response)
                completed(response, true, nil)
                break
            case .failure(let error):
                completed(nil, false, error)
                break
            }
        }
        
        
    }
    
}

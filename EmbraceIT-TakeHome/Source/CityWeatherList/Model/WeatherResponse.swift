//
//  WeatherResponse.swift
//  EmbraceIT-TakeHome
//
//  Created by Ahmer Mughal on 9/2/22.
//

import Foundation


struct WeatherResponse : Codable{
    
    let city : String
    let days : [WeatherDay]
    
    enum CodingKeys: String, CodingKey {
        case city = "resolvedAddress"
        case days
    }
    
    var avgTemp : Double {
        let total = days.reduce(0) { partialResult, weather in
            partialResult + weather.temp
        }
        return total / Double(days.count)
    }

    var avgWindSpeed : Double {
        let total = days.reduce(0) { partialResult, weather in
            partialResult + weather.windspeed
        }

        return total / Double(days.count)
    }
    
    var medianTemp : Double{
        
        let sortedTemps = days.sorted { current, next in
            current.temp < next.temp
        }

        return sortedTemps[(days.count-1) / 2].temp
    }
    
    var medianWindSpeed : Double{
        
        let sortedWindSpeed = days.sorted { current, next in
            current.windspeed < next.windspeed
        }
        return sortedWindSpeed[(days.count-1) / 2].windspeed
    }
    
}

struct WeatherDay: Codable{
    
    let temp : Double
    let windspeed: Double
    
}

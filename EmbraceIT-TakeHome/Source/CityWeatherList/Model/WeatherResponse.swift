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
        print("Total Temp: \(total)")
        print("Total Count: \(days.count)")
        return total / Double(days.count)
    }

    var avgWindSpeed : Double {
        let total = days.reduce(0) { partialResult, weather in
            partialResult + weather.windspeed
        }
        print("Total WindSpeed: \(total)")
        print("Total Count: \(days.count)")

        return total / Double(days.count)
    }
    
}

struct WeatherDay: Codable{
    
    let temp : Double
    let windspeed: Double
    
}

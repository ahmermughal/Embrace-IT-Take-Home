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
    
}

struct WeatherDay: Codable{
    
    let temp : Double
    let windspeed: Double
    
}

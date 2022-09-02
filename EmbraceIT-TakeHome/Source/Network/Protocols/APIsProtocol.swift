//
//  APIsProtocol.swift
//  EmbraceIT-TakeHome
//
//  Created by Ahmer Mughal on 9/2/22.
//

import Foundation

protocol APIsProtocol{
    
    static func getWeather(of city: String, from fromDate: String, to toDate: String, completed : @escaping (Result<WeatherResponse, NetworkError>) -> Void)
    
}

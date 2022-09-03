//
//  NetworkServiceProtocol.swift
//  EmbraceIT-TakeHome
//
//  Created by Ahmer Mughal on 9/2/22.
//

import Foundation

protocol NetworkServiceProtocol {

    
    func getAPI<T:Decodable>(url : String, params: [String : String], resultType: T.Type, completed: @escaping (Result<T, NetworkError>) -> Void)
}

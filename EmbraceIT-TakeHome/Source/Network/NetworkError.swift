//
//  NetworkErrors.swift
//  SadaPayTakeHome
//
//  Created by Ahmer Mughal on 6/11/22.
//

import Foundation

enum NetworkError: String, Error{
    case invalidURL = "Unable to complete your request."
    case invalidResponse = "Invalid response from the server"
    case invalidData = "Invalid data from the server"
}

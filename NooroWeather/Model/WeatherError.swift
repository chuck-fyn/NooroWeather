//
//  WeatherError.swift
//  NooroWeather
//
//  Created by Charles Prutting on 12/14/24.
//

import Foundation

enum WeatherError: LocalizedError {
    case invalidCity
    case networkError
    case serverError
    case invalidResponse
    
    var errorDescription: String? {
        switch self {
        case .invalidCity:
            return "No results found with this city name."
        case .networkError:
            return "Network Error"
        case .serverError:
            return "Server Error"
        case .invalidResponse:
            return "Invalid Response"
        }
    }
}

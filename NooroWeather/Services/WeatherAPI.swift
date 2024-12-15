//
//  WeatherAPI.swift
//  NooroWeather
//
//  Created by Charles Prutting on 12/14/24.
//

import Foundation

protocol WeatherAPIProtocol {
    func fetchWeather(for city: String) async throws -> Weather
}

final class WeatherAPI: WeatherAPIProtocol {
    private let apiKey = "2cc19dd37568454399e165726241412"
    private let session = URLSession.shared

    func fetchWeather(for city: String) async throws -> Weather {
        let encodedCity = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? city
        guard let url = URL(string: "https://api.weatherapi.com/v1/current.json?key=\(apiKey)&q=\(encodedCity)") else {
            throw WeatherError.invalidCity
        }
        
        do {
            let (data, response) = try await session.data(from: url)
            guard let response = response as? HTTPURLResponse else {
                throw WeatherError.invalidResponse
            }
            let code = response.statusCode
            switch code {
            case 200:
                return try JSONDecoder().decode(Weather.self, from: data)
            case 400:
                throw WeatherError.invalidCity
            case 400...499:
                throw WeatherError.serverError
            default:
                throw WeatherError.serverError
            }
        } catch URLError.notConnectedToInternet {
            throw WeatherError.networkError
        } catch is DecodingError {
            throw WeatherError.serverError
        }
    }
}

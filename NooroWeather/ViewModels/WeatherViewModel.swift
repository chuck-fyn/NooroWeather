//
//  WeatherViewModel.swift
//  NooroWeather
//
//  Created by Charles Prutting on 12/14/24.
//

import SwiftUI

import Foundation

class WeatherViewModel: ObservableObject {
    @Published var selectedCity = ""
    @Published var searchField = ""
    @Published var weatherData: Weather?
    @Published var isLoading = false
    
    private let weatherAPI = WeatherAPI()
    
    func loadUserDefaults() {
        selectedCity = UserDefaultsManager.loadCity() ?? ""
        fetchWeatherForCity(city: selectedCity)
    }
    
    func fetchWeatherForCity(city: String) {
        isLoading = true
        Task { @MainActor in
            do {
                weatherData = try await weatherAPI.fetchWeather(for: city)
                print("weather data is: \(weatherData)")
                isLoading = false
            } catch {
                print(error)
                isLoading = false
            }
        }
    }
    
    func saveCity(city: String) {
        selectedCity = city
        fetchWeatherForCity(city: city)
        UserDefaultsManager.saveCity(city: city)
    }
}

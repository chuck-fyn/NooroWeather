//
//  UserDefaultsManager.swift
//  NooroWeather
//
//  Created by Charles Prutting on 12/14/24.
//

import Foundation

final class UserDefaultsManager {
    static private let defaults = UserDefaults.standard
    static private let cityKey = "city"

    static func saveCity(city: String) {
        defaults.set(city, forKey: cityKey)
    }

    static func loadCity() -> String? {
        return defaults.string(forKey: cityKey)
    }
}

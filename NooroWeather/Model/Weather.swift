//
//  Weather.swift
//  NooroWeather
//
//  Created by Charles Prutting on 12/14/24.
//

import Foundation

struct Weather: Codable, Equatable {
    let location: Location
    let current: Current
}
    
struct Location: Codable, Equatable {
    let name: String
}
    
struct Current: Codable, Equatable {
    let temp_c: Double
    let temp_f: Double
    let condition: Condition
    let humidity: Int
    let uv: Double
    let feelslike_c: Double
    let feelslike_f: Double
}
        
struct Condition: Codable, Equatable {
    let text: String
    let icon: String
    let code: Int
}
